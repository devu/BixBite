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
	import flash.text.TextFormat;
	import org.bixbite.framework.modules.stats.signal.StatsSignal;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.view.DisplayViewContainer;
	
	/**
	 * @since 0.4.2
	 * @version  compatibility - 0.4.2
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
		private var frameRate		:int;
		
		/**
		 * Constructor
		 * @param	useTracer, turn on/off tracer sub view.
		 */
		public function StatsMonitor(useTracer:Boolean = true) 
		{
			if (useTracer){
				addView(new StatsTracer());
			}
		}
		
		override public function init():void 
		{
			frameRate = system.stage.frameRate;
			
			panel = new Sprite();
			panel.name = "statsPanel";
			panel.graphics.beginFill(0x000000, 0.8);
			panel.graphics.drawRect(0, 0, 310, 56);
			panel.mouseEnabled = false;
			
			context = panel;
			
			graph = new BitmapData(230, 56, true, 0x00000000);
			monitor = new Bitmap(graph);
			monitor.x = 80;
			panel.addChild(monitor);
			
			info_fps = createText(3, 2, 0xFFFF66);
			info_ms = createText(3, 10, 0x00FF00);
			info_mem = createText(3, 18, 0x00FFFF);
			info_max = createText(3, 26, 0xFF25F0);
			info_orient = createText(3, 34, 0xDEDEDE);
			
			panel.addChild(info_fps);
			panel.addChild(info_ms);
			panel.addChild(info_mem);
			panel.addChild(info_max);
			panel.addChild(info_orient);
			
			addSlot(StatsSignal.DRAW, drawGraph);
			addSlot(StatsSignal.UPDATE, updateText);
			
			addSlot(StageSignal.UPDATE, onStageUpdate);
		}
		
		private function drawGraph(s:StatsSignal):void
		{
			fps_graph = Math.min( graph.height, ( s.fps / frameRate ) * graph.height );
			mem_graph = Math.min( graph.height, Math.sqrt( Math.sqrt( s.mem * 5000 ) ) ) - 2;
			max_graph = Math.min( graph.height, Math.sqrt( Math.sqrt( s.max * 5000 ) ) ) - 2;
			
			graph.scroll( -1, 0 );
			
			graph.setPixel32( 228, 56 - fps_graph, 0xFFFFFF66);
			graph.setPixel32( 228, 56 - ( ( s.timer - s.ms ) >> 1 ), 0xFF00FF00 );
			graph.setPixel32( 228, 56 - mem_graph, 0xFF00FFFF);
			graph.setPixel32( 228, 56 - max_graph,  0xFFFF0000);
		}
		
		private function updateText(s:StatsSignal):void
		{
			info_fps.text = s.infoFPS;
			info_mem.text = s.infoMEM;
			info_max.text = s.infoMAX;
			info_ms.text = s.infoMS;
		}
		
		private function onStageUpdate(s:StageSignal):void 
		{
			info_orient.text = (s.orientation == "stageOrientationPortrait") ? "PORTRAIT" : "LANDSCAPE";
		}
		
		private function createText(posX:Number, posY:Number, color:uint = 0xFFFFFF, w:Number = 70, h:Number = 18):TextField
		{
			var tf:TextFormat = new TextFormat("tahoma", 9, color);
			
			var t:TextField = new TextField();
			t.mouseEnabled = false;
			t.selectable = false;
			t.x = posX;
			t.y = posY;
			t.defaultTextFormat = tf;
			t.width = w;
			t.height = h;
			
			return t;
		}
		
	}

}