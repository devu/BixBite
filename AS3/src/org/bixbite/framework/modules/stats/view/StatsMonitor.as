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

package org.bixbite.framework.modules.stats.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.factories.TextFactory;
	import org.bixbite.framework.modules.stats.data.StatsData;
	import org.bixbite.framework.signals.StatsSignal;
	import org.bixbite.framework.view.DisplayViewContainer;
	
	/**
	 * @version  compatibility - 0.5.1
	 * @since 0.4.2
	 * 
	 * StatsMonitor
	 */
	public class StatsMonitor extends DisplayViewContainer 
	{
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
		private var panel			:Sprite;
		
		/**
		 * Constructor
		 */
		public function StatsMonitor() 
		{
			
		}
		
		override public function init():void 
		{
			var textFactory:TextFactory = TextFactory.instance;
			
			panel = new Sprite();
			panel.graphics.beginFill(0x000000, 0.8);
			panel.graphics.drawRect(0, 0, 310, 56);
			panel.mouseEnabled = false;
			
			graph = new BitmapData(230, 56, true, 0x00000000);
			monitor = new Bitmap(graph);
			monitor.x = 80;
			panel.addChild(monitor);
			
			info_fps 	= textFactory.createSimpleText(panel, 3, 2 , 70, 18, 0xFFFF66);
			info_ms 	= textFactory.createSimpleText(panel, 3, 10, 70, 18, 0x00FF00);
			info_mem 	= textFactory.createSimpleText(panel, 3, 18, 70, 18, 0x00FFFF);
			info_max 	= textFactory.createSimpleText(panel, 3, 26, 70, 18, 0xFF25F0);
			info_orient = textFactory.createSimpleText(panel, 3, 34, 70, 18, 0xDEDEDE);
			
			panel.addChild(info_fps);
			panel.addChild(info_ms);
			panel.addChild(info_mem);
			panel.addChild(info_max);
			panel.addChild(info_orient);
			
			addSlot(StatsSignal.DRAW, drawGraph);
			addSlot(StatsSignal.UPDATE, update);
			addSlot(StatsSignal.UPDATE_REALTIME, updateRealtime);
			//addSlot(StageSignal.RESIZE, onStageResize);
			
			setContext("statsPanel", panel);
		}
		
		private function drawGraph(s:ISignal):void
		{
			var data:StatsData = s.params[0];
			
			var fps			:int 		= data.fps;
			var mem			:Number 	= data.mem;
			var max			:Number 	= data.max;
			var timer		:int 		= data.timer;
			var ms			:int 		= data.ms;
			var frameRate	:Number 	= data.frameRate;
			
			fps_graph = Math.min( graph.height, ( fps / frameRate ) * graph.height );
			mem_graph = Math.min( graph.height, Math.sqrt( Math.sqrt( mem * 5000 ) ) ) - 2;
			max_graph = Math.min( graph.height, Math.sqrt( Math.sqrt( max * 5000 ) ) ) - 2;
			
			graph.scroll( -1, 0 );
			
			graph.setPixel32( 228, 56 - fps_graph, 0xFFFFFF66);
			graph.setPixel32( 228, 56 - ( ( timer - ms ) >> 1 ), 0xFF00FF00 );
			graph.setPixel32( 228, 56 - mem_graph, 0xFF00FFFF);
			graph.setPixel32( 228, 56 - max_graph,  0xFFFF0000);
		}
		
		private function update(s:ISignal):void
		{
			var data:StatsData = s.params[0];
			
			info_fps.text = data.infoFPS;
			info_mem.text = data.infoMEM;
			info_max.text = data.infoMAX;
		}
		
		private function updateRealtime(s:ISignal):void
		{
			var data:StatsData = s.params[0];
			
			info_ms.text = data.infoMS;
		}
		/*
		private function onStageResize(s:StageSignal):void 
		{
			//trace(this, "resize");
			//info_orient.text = (s.orientation == "stageOrientationPortrait") ? "PORTRAIT" : "LANDSCAPE";
		}
		*/
		
	}

}