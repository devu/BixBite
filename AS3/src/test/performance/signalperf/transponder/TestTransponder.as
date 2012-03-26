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
	import flash.utils.getTimer;
	import org.bixbite.core.Transponder;
	import test.performance.signalperf.signal.TestSignal;
	
	/**
	 * @version  compatibility - 0.4.5
	 */
	public class TestTransponder extends Transponder 
	{
		private var testSignal:TestSignal;
		private var slotReference:Function;
		
		public function TestTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			testSignal = new TestSignal();
			attachSignal(testSignal);
			
			system.addListener(MouseEvent.CLICK, runTest);
			
			addSlot("fullTriade", onFullTriade);
		}
		
		private function runTest(e:MouseEvent):void 
		{
			slotReference = getSlotReference("fullTriade")[0]; //turbo mode
			
			testSignal.time = getTimer();
			sendSignal("signalFromCtrl");
		}
		
		private function onFullTriade(s:TestSignal):void 
		{
			slotReference(signal); //turbo mode
			//sendSignal("fullTriade");
		}
	}

}