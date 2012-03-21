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
	import org.bixbite.framework.modules.stats.signal.StatsSignal;
	import org.bixbite.framework.modules.stats.signal.TraceSignal;
	import test.performance.signalperf.signal.TestSignal;
	import flash.utils.setInterval;
	
	/**
	 * ...
	 */
	public class TestView extends View 
	{
		private var testSignal:TestSignal;
		
		public function TestView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("signalFromModel", onSignalFromModel);
			addSlot("signalFromCtrl", onSignalFromController);
			addSlot("signalFromModelFullTriade", onSignalFromModelFullTriade);
		}
		
		/**
		 * Signals from Controller should arrive AFTER signal from Model, if Controller broadcasted exactly same type of signal and both, Model and View listen to it
		 * Phase of this signal should be always 1. Usign phase value you can recognize within View who is calling.
		 * @param	s
		 */
		private function onSignalFromController(s:TestSignal):void
		{
			trace("Signal: Controller->View  Phase:", s.phase);
		}
		
		/**
		 * Signals from Model should always arrive BEFORE signal from Controller, if Controller broadcasted exactly same type of signal and both, Model and View listen to it.
		 * The reason being is to have opportunity to manage the flow and Model can decide about cancelation of the 2nd phase.
		 * @param	s
		 */
		private function onSignalFromModel(s:TestSignal):void 
		{
			var MAX:int = 100000;
			var i:int;
			
			trace("Signal: Controller->Model->View  Phase:", s.phase);
			
			testSignal = s;
			attachSignal(testSignal);
			testSignal.total = getTimer();
			
			for (i = 0 ; i < MAX; i++){
				fullTriadeTest();
			}
			
			var result:String = "View->Controller->Model->View x"+MAX+" " + (getTimer() - testSignal.total) + "ms";
			attachSignal(new TraceSignal("STANDARD", result, 0));
			sendSignal(StatsSignal.TRACE);
		}
		
		private function onSignalFromModelFullTriade(s:TestSignal):void
		{
			//end point of full triade test
		}
		
		private function fullTriadeTest():void
		{
			sendSignal("fullTriade");
		}
		
	}

}