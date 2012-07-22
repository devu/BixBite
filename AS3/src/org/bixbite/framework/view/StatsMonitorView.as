/**The MIT License

@copy (c) 2012 Devu Design Limited, Daniel Wasilewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package org.bixbite.framework.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.Stats;
	import org.bixbite.namespaces.STATS;
	
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.factories.TextFactory;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.StageManager;
	
	
	/**
	 * @version  compatibility - 0.6.1
	 * @since 0.4.2
	 * 
	 * StatsMonitor
	 */
	public class StatsMonitorView extends View 
	{
		use namespace STATS
		
		private var mem_graph		:Number = 0;
		private var max_graph		:Number = 0;
		private var fps_graph		:Number = 0;
		
		private var monitor			:Bitmap;
		private var graph			:BitmapData;

		private var panel			:Sprite;
		private var info_fps		:TextField;
		private var info_ms			:TextField;
		private var info_mem		:TextField;
		private var info_max		:TextField;
		private var info_orient		:TextField;
		
		/**
		 * Constructor
		 */
		public function StatsMonitorView() 
		{
			
		}
		
		override public function init():void 
		{
			var tFactory:TextFactory = TextFactory.getInstance();
			
			panel = new Sprite();
			panel.graphics.beginFill(0x000000, 0.8);
			panel.graphics.drawRect(0, 0, 310, 56);
			panel.mouseEnabled = false;
			
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
			
			addSlot(Stats.DRAW, drawGraph);
			addSlot(Stats.UPDATE, update);
			addSlot(Stats.UPDATE_REALTIME, updateRealtime);
			
			addSlot(StageSignal.ON_ORIENTATION_CHANGED, onOrietnationChanged);
			
			sendSignal(DisplaySignal.SET_CONTEXT, { name:"statsPanel", context:panel } );
			sendSignal(DisplaySignal.ADD_CONTEXT, { name:"statsPanel", container:"stage" } );
		}
		
		private function drawGraph(s:Signal):void
		{
			var params		:Object 	= s.params;
			
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
		}
		
		private function update(s:Signal):void
		{
			var params:Object = s.params;
			
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
			
			removeSlot(Stats.DRAW);
			removeSlot(Stats.UPDATE);
			removeSlot(Stats.UPDATE_REALTIME);
			removeSlot(StageSignal.ON_ORIENTATION_CHANGED);
			
			super.destroy();
		}
		
	}

}