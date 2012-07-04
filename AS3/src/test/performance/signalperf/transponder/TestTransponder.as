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

package test.performance.signalperf.transponder 
{
	import flash.events.MouseEvent;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Transponder;
	import test.performance.signalperf.Signals;
	
	/**
	 * @version  compatibility - 0.5.2
	 */
	public class TestTransponder extends Transponder 
	{
		private var slotReference:Function;
		
		//private var iterator:int = 0;
		//private var startTime:int = 0;
		
		public function TestTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(Signals.INIT_TEST, onTestInit);
		}
		
		private function onTestInit(s:ISignal):void 
		{
			addSensor(MouseEvent.CLICK, startTest);
			addSlot(Signals.RUN_TEST, onRunTest);
		}
		
		private function startTest(e:MouseEvent):void
		{
			slotReference = getSlotReference(Signals.RUN_TEST)[0];
			sendSignal(Signals.START_TEST);
		}
		
		private function onRunTest(s:ISignal):void
		{
			//standard
			//sendSignal(Signals.RUN_TEST);
			//SRS
			slotReference(signal);
		}
	}

}