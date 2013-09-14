/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.signalperf.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Slot;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * @langversion	3.0
	 */
	public class TestRunnerSRS extends Behaviour 
	{
		private var slot:Slot;
		
		override public function init():void 
		{
			slot = getSlots(SignalPerformance.RUN_TEST_SRS).getSlotByIndex(0);
		}
		
		override public function execute(s:Signal):void
		{
			slot.send(s);
		}
		
	}

}