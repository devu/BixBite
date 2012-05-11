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

package test.performance.signalperf.view 
{
	import flash.utils.getTimer;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signals.StatsSignal;
	import test.performance.signalperf.Signals;
	
	/**
	 * @version  compatibility - 0.5.2
	 */
	public class TestView extends View
	{
		private var slotReference:Function;
		
		public function TestView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(Signals.BEGIN_TEST, onBeginTest);
			addSlot(Signals.RUN_TEST, onRunTest);
		}
		
		private function onRunTest(s:ISignal):void 
		{
			
		}
		
		private function onBeginTest(s:ISignal):void
		{
			slotReference = getSlotReference(Signals.RUN_TEST)[0];
			
			var startTime:int = getTimer();
			
			//standard
			//for (var i:int = 0 ; i < 1000000; i++) sendSignal(Signals.RUN_TEST);
			//SRS
			for (var i:int = 0 ; i < 10000000; i++) slotReference(signal);
			
			sendSignal(StatsSignal.TRACE, [0, "Time:", String(getTimer() - startTime)]);
		}
	}

}