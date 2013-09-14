/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.signalperf.transponder 
{
	import flash.events.MouseEvent;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Slot;
	import org.bixbite.core.Transponder;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * @langversion	3.0
	 */
	public class TestTransponder extends Transponder 
	{
		private var slot:Slot;
		
		public function TestTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.CLICK, startTest);
			addSlot(SignalPerformance.RUN_TEST_SRS, onRunTestSrs);
			addSlot(SignalPerformance.RUN_TEST_STANDARD, onRunTestStandard);
			
			transmit(SignalPerformance.BEGIN_NATIVE_TEST);
		}
		
		private function startTest(e:MouseEvent):void
		{
			slot = getSlots(SignalPerformance.RUN_TEST_SRS).getSlotByIndex(0);
			sendSignal(SignalPerformance.START_TEST);
		}
		
		private function onRunTestSrs(s:Signal):void
		{
			slot.send(signal);
		}
		
		private function onRunTestStandard(s:Signal):void 
		{
			sendSignal(SignalPerformance.RUN_TEST_STANDARD);
		}
	}

}