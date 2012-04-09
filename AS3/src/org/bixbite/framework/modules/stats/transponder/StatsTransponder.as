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

package org.bixbite.framework.modules.stats.transponder 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signals.StatsSignal;
	
	/**
	 * @version  compatibility - 0.5.0
	 * @since 0.4.1
     */
	public class StatsTransponder extends Transponder 
	{
		private var panel:Sprite;
		
		public function StatsTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN	, onMouseDown);
			addSensor(MouseEvent.MOUSE_UP	, onMouseUp);
			addSensor(Event.ENTER_FRAME		, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			sendSignal(StatsSignal.CALCULATE);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			if (findObjectByName("statsPanel")){
				panel = getObjectByName("statsPanel") as Sprite;
				panel.startDrag();
			}
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if (panel) {
				panel.stopDrag();
				panel = null;
			}
		}
	}

}