package org.bixbite.examples.stats
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MobileStats extends Sprite
	{
		private var mem				:Number = 0;
		private var mem_graph		:Number = 0;
		private var max				:Number = 0;
		private var max_graph		:Number = 0;
		private var fps				:Number = 0;
		private var fps_graph		:Number = 0;
		
		private var monitor			:Bitmap;
		private var graph			:BitmapData;
		
		private var info_fps		:TextField;
		private var info_ms			:TextField;
		private var info_mem		:TextField;
		private var info_max		:TextField;
		private var info_orient		:TextField;
		private var info_trace		:TextField;
		private var data			:Array = [];
		private var timer			:int;
		private var ms				:int;
		private var ms_prev			:int;
		
		private var running			:Boolean = true;
		private var initialize		:Boolean = false;
		
		public function MobileStats() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		private function init(e:Event):void
		{
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
			
			if (!initialize){
				initialize = true;
				create();
			}
			checkOrientation();
			start();
			
		}
		
		private function create():void
		{
			graph = new BitmapData(230, 56, true, 0x00000000);
			monitor = new Bitmap(graph);
			monitor.x = 60;
			
			info_fps = createText(3, 2, 0xFFFF66);
			info_ms = createText(3, 10, 0x00FF00);
			info_mem = createText(3, 18, 0x00FFFF);
			info_max = createText(3, 26, 0xFF25F0);
			info_orient = createText(3, 34, 0xDEDEDE);
			
			addChild(info_fps);
			addChild(info_ms);
			addChild(info_mem);
			addChild(info_max);
			addChild(info_orient);
			
			addEventListener(MouseEvent.MOUSE_DOWN, toogleRunPause);
		}
		
		private function start():void
		{
			graphics.clear();
			graphics.beginFill(0x000000, 1);
			graphics.drawRect(0, 0, stage.stageWidth, 54);
			
			addChild(monitor);
			
			if (info_trace) addChild(info_trace);
			
			running = true;
			addEventListener(Event.ENTER_FRAME, calculate);
		}
		
		private function pause():void
		{
			for (var i:int = 0; i < 56; i++) graph.setPixel32(228, i, 0xFF00FFFF);
			
			graphics.clear();
			graphics.beginFill(0x000000, 0.5);
			graphics.drawRect(0, 0, 60, 54);
			
			removeEventListener(Event.ENTER_FRAME, calculate);
			
			removeChild(monitor);
			if (info_trace) removeChild(info_trace);
			
			info_fps.text = "PAUSED";
			
			running = false;
		}
		
		private function toogleRunPause(e:MouseEvent):void 
		{
			(running) ? pause() : start();
		}
		
		public function trace(name:String, value:*, line:int = 0):void
		{
			if (!info_trace){
				info_trace = createText(290, 0, 0xFFFFFF, 300, 54);
				info_trace.backgroundColor = 0x000000;
				info_trace.background = true;
				info_trace.autoSize = "left";
				addChild(info_trace);
			}
			
			data[line] = { name:name, value:value.toString() };
			updateTrace();
		}
		
		public function clearTrace():void
		{
			data = [];
		}
		
		private function createText(posX:Number, posY:Number, color:uint = 0xFFFFFF, w:Number = 70, h:Number = 18):TextField
		{
			var tf:TextFormat = new TextFormat("tahoma", 9, color);
			
			var t:TextField = new TextField();
			t.x = posX;
			t.y = posY;
			t.defaultTextFormat = tf;
			t.width = w;
			t.height = h;
			t.selectable = false;
			
			return t;
		}
		
		public function calculate(e:Event):void
		{
			if (!running) return;
			
			timer = getTimer();
			
			if( timer - 1000 > ms_prev && stage){
				ms_prev = timer;
				mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				max = max > mem ? max : mem;
				
				drawGraph();
				
				info_fps.text = "FPS: " + fps + " / " + stage.frameRate;
				info_mem.text = "MEM: " + mem;
				info_max.text = "MAX: " + max;
				
				fps = 0;
			}
			
			fps++;
			
			info_ms.text = "MS: " + (timer - ms);
			ms = timer;
		}
		
		private function drawGraph():void
		{
			fps_graph = Math.min( graph.height, ( fps / stage.frameRate ) * graph.height );
			mem_graph = Math.min( graph.height, Math.sqrt( Math.sqrt( mem * 5000 ) ) ) - 2;
			max_graph = Math.min( graph.height, Math.sqrt( Math.sqrt( max * 5000 ) ) ) - 2;
			
			graph.scroll( -1, 0 );
			
			graph.setPixel32( 228, 56 - fps_graph, 0xFFFFFF66);
			graph.setPixel32( 228, 56 - ( ( timer - ms ) >> 1 ), 0xFF00FF00 );
			graph.setPixel32( 228, 56 - mem_graph, 0xFF00FFFF);
			graph.setPixel32( 228, 56 - max_graph,  0xFFFF0000);
		}
		
		private function updateTrace():void
		{
			if (info_trace){
				info_trace.text = "";
				for (var i:int = 0; i < data.length; i++)
					info_trace.appendText((data[i] == null) ? "\n" : data[i].name + " " + data[i].value +"\n");
			}
		}
		
		private function destroy(e:Event):void
		{
			graph.dispose();
			while (numChildren > 0) removeChildAt(0);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		public function onResize():void
		{
			if(running){
				
				graphics.clear();
				graphics.beginFill(0x000000, 1);
				graphics.drawRect(0, 0, stage.stageWidth, 54);
				
				checkOrientation();
			}
		}
		
		private function checkOrientation():void
		{
			info_orient.text = (stage.stageWidth < stage.stageHeight) ? "PORTRAIT" : "LANDSCAPE";
		}
		
	}

}