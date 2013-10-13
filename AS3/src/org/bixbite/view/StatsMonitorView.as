/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.factories.TextFactory;
	import org.bixbite.signal.Display;
	import org.bixbite.Stats;
	import org.bixbite.view.context.StatsMonitor;
	
	/**
	 * @langversion	3.0
	 */
	public class StatsMonitorView extends View 
	{
		private var container		:IContext;
		private var panel			:IContext;
		
		private var mem_graph		:Number = 0;
		private var max_graph		:Number = 0;
		private var fps_graph		:Number = 0;
		
		private var monitor			:Bitmap;
		private var graph			:BitmapData;
		
		private var info_fps		:TextField;
		private var info_ms			:TextField;
		private var info_mem		:TextField;
		private var info_max		:TextField;
		private var info_orient		:TextField;
		private var info_size		:TextField;
		
		override public function init():void
		{
			var tFactory:TextFactory = TextFactory.getInstance();
			
			container = getContext("debug");
			panel = registerContext("statsPanel", new StatsMonitor());
			container.addChild(panel);
			
			graph = new BitmapData(230, 56, true, 0x00000000);
			monitor = new Bitmap(graph);
			monitor.x = 80;
			panel.body.addChild(monitor);
			
			tFactory.setTextFormat("stats", "tahoma", 9, 0xFFFFFF, "left");
			
			info_fps 	= tFactory.createText(panel.body, "stats", 3, 2 , 70, 18, 0xFFFF66);
			info_ms 	= tFactory.createText(panel.body, "stats", 3, 10, 70, 18, 0x00FF00);
			info_mem 	= tFactory.createText(panel.body, "stats", 3, 18, 70, 18, 0x00FFFF);
			info_max 	= tFactory.createText(panel.body, "stats", 3, 26, 70, 18, 0xFF25F0);
			info_orient = tFactory.createText(panel.body, "stats", 3, 34, 70, 18, 0xDEDEDE);
			info_size 	= tFactory.createText(panel.body, "stats", 3, 42, 70, 18, 0xDEDEDE);
			
			container.addChild(panel);
			
			addSlot(Display.SET_DISPLAY, onDisplaySet);
			addSlot(Stats.UPDATE, update);
			addSlot(Stats.UPDATE_REALTIME, updateRealtime);
			
			addSlot(Display.ON_ORIENTATION_CHANGED, onOrietnationChanged);
			addSlot(Display.ON_RESIZE, onResize);
			
			sendSignal(Display.GET_DISPLAY);
			panel.draw();
			
			sendSignal(Stats.VIEW_READY);
		}
		
		private function onDisplaySet(s:Signal):void 
		{
			info_orient.text = s.params.orientation;
			info_size.text = s.params.width + "x" +s.params.height;
		}
		
		private function update(s:Signal):void
		{
			var params:Object = s.params;
			
			var fps			:int 		= params.fps;
			var mem			:Number 	= params.mem;
			var max			:Number 	= params.max;
			var timer		:int 		= params.timer;
			var ms			:int 		= params.ms;
			var frameRate	:Number 	= params.frameRate;
			
			fps_graph = Math.min( graph.height, ( fps / frameRate ) * graph.height );
			mem_graph = Math.min( graph.height, Math.sqrt( Math.sqrt( mem * 5000 ) ) ) - 2;
			max_graph = Math.min( graph.height, Math.sqrt( Math.sqrt( max * 5000 ) ) ) - 2;
			
			graph.scroll( -1, 0 );
			
			graph.setPixel32( 228, 56 - fps_graph, 0xFFFFFF66);
			graph.setPixel32( 228, 56 - ( ( timer - ms ) >> 1 ), 0xFF00FF00 );
			graph.setPixel32( 228, 56 - mem_graph, 0xFF00FFFF);
			graph.setPixel32( 228, 56 - max_graph,  0xFFFF0000);
			
			info_fps.text = params.infoFPS;
			info_mem.text = params.infoMEM;
			info_max.text = params.infoMAX;
		}
		
		private function updateRealtime(s:Signal):void
		{
			info_ms.text = s.params.infoMS;
		}
		
		private function onOrietnationChanged(s:Signal):void 
		{
			info_orient.text = s.params.orientation;
		}
		
		private function onResize(s:Signal):void 
		{
			info_size.text = s.params.width + "x" +s.params.height;
		}
		
		override public function destroy():void 
		{
			panel.destroy();
			panel = null;
			graph.dispose();
			graph = null;
			monitor = null;
			
			removeSlot(Stats.UPDATE);
			removeSlot(Stats.UPDATE_REALTIME);
			removeSlot(Display.ON_ORIENTATION_CHANGED);
			
			super.destroy();
		}
		
	}

}