/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import org.bixbite.core.interfaces.IContextContainer;
	
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	import org.bixbite.framework.factories.TextFactory;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.Stats;
	import org.bixbite.framework.view.context.StatsMonitor;
	
	/**
	 * @langversion	3.0
	 */
	public class StatsMonitorView extends View 
	{
		private var root			:IContextContainer;
		private var panel			:StatsMonitor;
		
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
		
		override public function init():void
		{
			var tFactory:TextFactory = TextFactory.getInstance();
			
			root = getContainer("debug");
			panel = StatsMonitor(registerContext("statsPanel", StatsMonitor));
			
			graph = new BitmapData(230, 56, true, 0x00000000);
			monitor = new Bitmap(graph);
			monitor.x = 80;
			panel.addChild(monitor);
			
			tFactory.setTextFormat("stats", "tahoma", 9, 0xFFFFFF, "left");
			
			info_fps 	= tFactory.createText(panel, "stats", 3, 2 , 70, 18, 0xFFFF66);
			info_ms 	= tFactory.createText(panel, "stats", 3, 10, 70, 18, 0x00FF00);
			info_mem 	= tFactory.createText(panel, "stats", 3, 18, 70, 18, 0x00FFFF);
			info_max 	= tFactory.createText(panel, "stats", 3, 26, 70, 18, 0xFF25F0);
			info_orient = tFactory.createText(panel, "stats", 3, 34, 70, 18, 0xDEDEDE);
			
			addSlot(DisplaySignal.SET_DISPLAY, onDisplaySet);
			addSlot(Stats.UPDATE, update);
			addSlot(Stats.UPDATE_REALTIME, updateRealtime);
			
			addSlot(DisplaySignal.ON_ORIENTATION_CHANGED, onOrietnationChanged);
			
			root.add(panel);
			
			sendSignal(DisplaySignal.GET_DISPLAY);
			panel.draw();
		}
		
		private function onDisplaySet(s:Signal):void 
		{
			info_orient.text = s.params.orientation;
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
		
		override public function destroy():void 
		{
			panel.graphics.clear();
			graph.dispose();
			graph = null;
			monitor = null;
			
			while (panel.numChildren > 0) panel.removeChildAt(0);
			stage.removeChild(panel);
			panel = null;
			
			removeSlot(Stats.UPDATE);
			removeSlot(Stats.UPDATE_REALTIME);
			removeSlot(DisplaySignal.ON_ORIENTATION_CHANGED);
			
			super.destroy();
		}
		
	}

}