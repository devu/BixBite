/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.signalperf.view 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Slot;
	import org.bixbite.core.View;
	import org.bixbite.framework.view.context.OutputContext;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * @langversion	3.0
	 */
	public class TestView extends View
	{
		private var slot	:Slot;
		private var output	:OutputContext;
		
		public function TestView() 
		{
			
		}
		
		override public function init():void 
		{
			output = OutputContext(registerContext("signalPerf", OutputContext));
			output.y = 60;
			addContext("signalPerf", "stage");
			
			addSlot(SignalPerformance.NATIVE_TEST_RESULTS, onNativeTest);
			addSlot(SignalPerformance.CALLBACK_TEST_RESULTS, onCallbackTest);
			addSlot(SignalPerformance.BEGIN_TEST, onBeginTest);
			addSlot(SignalPerformance.RUN_TEST_SRS, onRunTestSRS);
			addSlot(SignalPerformance.RUN_TEST_STANDARD, onRunTestStandard);
		}
		
		private function onNativeTest(s:Signal):void 
		{
			output.appendText("NATIVE: " + s.params.time + "ms \n");
		}
		
		private function onCallbackTest(s:Signal):void 
		{
			output.appendText("CALLBACK: " + s.params.time + "ms \n");
		}
		
		private function onRunTestSRS(s:Signal):void 
		{
			//trace("recieved");
		}
		
		private function onRunTestStandard(s:Signal):void 
		{
			//trace("recieved");
		}
		
		private function onBeginTest(s:Signal):void
		{
			setTimeout(startTest, 1000);
		}
		
		private function startTest():void
		{
			var max:int = 100000;
			output.text = max + " iterations, " + String(max * 3) + " signals\n";
			
			slot = getSlots(SignalPerformance.RUN_TEST_SRS).getSlotByIndex(0);
			
			var startTime:int = getTimer();
			for (var i:int = 0 ; i < max; i++) sendSignal(SignalPerformance.RUN_TEST_STANDARD);
			output.appendText("STANDARD: " + String(getTimer() - startTime + "ms \n"));
			
			startTime = getTimer();
			for (i = 0 ; i < max; i++) slot.send(signal);
			output.appendText("SRS: " + String(getTimer() - startTime + "ms \n"));
			
			sendSignal(SignalPerformance.BEGIN_NATIVE_TEST, { max:max } );
		}
	}

}