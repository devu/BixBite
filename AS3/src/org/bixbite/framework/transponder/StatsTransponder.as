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

package org.bixbite.framework.transponder 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.StatsSignal;
	import org.bixbite.framework.Stats;
	import org.bixbite.namespaces.STATS;
	
	/**
	 * @version  compatibility - 0.6.1
	 * @since 0.4.1
     */
	public class StatsTransponder extends Transponder 
	{
		use namespace STATS
		
		private var panel		:Sprite;
		private var calculate	:Function;
		
		public function StatsTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN	, onMouseDown);
			addSensor(MouseEvent.MOUSE_UP	, onMouseUp);
			
			addSlot(StatsSignal.START, onStart);
			addSlot(StatsSignal.PAUSE, onPause);
		}
		
		private function onStart(s:Signal):void 
		{
			calculate = getSlotReference(Stats.CALCULATE)[0];
			addSensor(Event.ENTER_FRAME		, onEnterFrame);
		}
		
		private function onPause(s:Signal):void 
		{
			removeSensor(Event.ENTER_FRAME	, onEnterFrame);
			calculate = null;
		}
		
		private function onEnterFrame(e:Event):void 
		{
			//SRS
			calculate(signal);
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
		
		override public function destroy():void 
		{
			removeSensor(Event.ENTER_FRAME		, onEnterFrame);
			removeSensor(MouseEvent.MOUSE_DOWN	, onMouseDown);
			removeSensor(MouseEvent.MOUSE_UP	, onMouseUp);
			
			removeSlot(Stats.CALCULATE);
			removeSlot(StatsSignal.START);
			removeSlot(StatsSignal.PAUSE);
			
			calculate = null;
			panel = null;
			
			super.destroy();
		}
	}

}