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

package test.performance.signalperf.model 
{
	import flash.utils.getTimer;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	import test.performance.signalperf.signal.TestSignal;
	
	/**
	 * @version  compatibility - 0.4.4
	 */
	public class TestModel extends Model 
	{
		private var testSignal		:TestSignal;
		private var slotReference	:Function;
		
		public function TestModel() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("signalFromCtrl", onSignalFromCtrl);
			addSlot("fullTriade", onFullTriade);
		}
		
		private function onSignalFromCtrl(s:TestSignal):void
		{
			trace("Signal: Controller->Model", s.time - getTimer());
			
			testSignal = s;
			attachSignal(testSignal);
			
			slotReference = getSlotReference("signalFromModelFullTriade")[0]; //turbo mode
			sendSignal("signalFromModel");
		}
		
		private function onFullTriade(s:TestSignal):void
		{
			
			slotReference(signal); //turbo mode
			//sendSignal("signalFromModelFullTriade");
		}
		
	}

}