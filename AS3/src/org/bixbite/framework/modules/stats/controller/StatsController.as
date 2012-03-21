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

package org.bixbite.framework.modules.stats.controller 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.bixbite.core.Controller;
	import org.bixbite.framework.modules.stats.signal.StatsSignal;
	import org.bixbite.framework.modules.stats.signal.TraceSignal;
	
	/**
	 * @version  compatibility - 0.4.2
	 * @since 0.4.1
	 * 
     * StatsController, will capture event when stats panel has been clicked and perform some basic task.
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
			
			addSlot(StatsSignal.TRACE, onTrace);
		}
		
		//Capture request from View and Pass to Model in order to keep MVC signal flow.
		private function onTrace(s:TraceSignal):void 
		{
			attachSignal(s);
			sendSignal(StatsSignal.TRACE);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var objects:Array = system.getObjects();
			
			for each(var o:DisplayObject in objects){
				if (o.name == "statsPanel"){
					statsPanel = o as Sprite;
					statsPanel.startDrag();
					return;
				}
			}
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if (statsPanel) statsPanel.stopDrag();
			statsPanel = null;
		}
	}

}