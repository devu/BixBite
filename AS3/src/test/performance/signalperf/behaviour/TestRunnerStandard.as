/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.signalperf.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * @langversion	3.0
	 */
	public class TestRunnerStandard extends Behaviour 
	{
		override public function execute(s:Signal):void
		{
			sendSignal(SignalPerformance.RUN_TEST_STANDARD);
		}
		
	}

}