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

package examples.stats.controller 
{
	import examples.stats.signal.StatsSignal;
	import examples.stats.signal.TraceSignal;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.bixbite.core.Controller;
	
	/**
	 * @version  compatibility - 0.4.3
	 * 
     * StatsController, will capture event when stats panel has been clicked and perform some basic task.
     * For demonstration purposes, will broadcast TraceSignal to show how sub-view of StatsView is being used.
     *
     * Notice, that in all examples you can't find a single event listener being added to any view.
     * You might argue, controlling stuff like that is a bit over-bloated and complicated. However this is exactly what Controllers are for.
     * Capture user input, work out what to do, perform GUI logic and respond to Model or directly to any View involved.
     *
     * But in those small examples for presentation purposes we have custom implementation each time.
     * In proper application you are more likely to use MouseController or TouchController class that will work out all inputs automatically.
     * There rest of your controllers will only reuse already established signal system. So you don't have to repeat yourself.
     */
	public class StatsController extends Controller 
	{
		private var statsPanel:Sprite;
		
		public function StatsController() 
		{
			
		}
		
		override public function init():void 
		{
			system.addListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			system.addListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var objects:Array = system.getObjects();
			
			for each(var o:DisplayObject in objects){
				if (o.name == "statsPanel"){
					statsPanel = o as Sprite;
					statsPanel.startDrag();
					
					attachSignal(new TraceSignal("trace something:", this));
					sendRequest(StatsSignal.TRACE, onTraceResponse);
					
					return;
				}
			}
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if(statsPanel){
				statsPanel.stopDrag();
				statsPanel = null;
			}
		}
		
		private function onTraceResponse(s:StatsSignal):void
		{
			trace("fired");
		}
	}

}