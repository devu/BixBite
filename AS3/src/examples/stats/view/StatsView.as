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

package examples.stats.view 
{
	import examples.stats.signal.StatsSignal;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.StageSignal;
	
	/**
	 * @version  compatibility - 0.4.4
	 * 
	 * StatsView, visual representation of data comning from StatsModel.
	 * Now you can let your imagination fly. Create your custom views as you like it without changing Model and Controller at all.
	 * You can even have multiple views reacting on the same set of signals.
	 * Look at StatsTraceView for instance. In MobileStats fork we had all functionality build into one class. 
	 * Here we have proper modular system that is more convinient to manage, change and extend.
	 * 
	 * In this example we also shows how we can construct additional subview on demand.
	 */
	public class StatsView extends View 
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
		 * Constructor, there is one important thing about constructors in Bixbite worth to remember.
		 * In any subclass of any Actor method init() will fire before constructor! 
		 * This is very convinient in many situations, but sometimes you maight want to reverse this order, especialy when using injectors via constructor signature.
		 * The way to do so, is to assign your values, and at the end of constructor (after all referencing is done) call super();.
		 * Because of reverse order, you need to remember that stage will not be available at this point within constructor. Just init() can do the job.
		 * 
		 * @param	useTracer, turn on/off tracer sub view.
		 */
		public function StatsView(useTracer:Boolean = true) 
		{
			if (useTracer){
				//this is why nested views and dependency injection make perfect sense.
				var tracer:StatsTraceView = new StatsTraceView(panel);
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
			
			system.stage.addChild(panel);
			
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
		
		//TODO, subject to concideration build-in to framework branches factory methods to create shapes and text fields.
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