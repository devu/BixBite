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
	public class TestBehaviour extends Behaviour 
	{
		
		public function TestBehaviour() 
		{
			
		}
		
		override public function execute(s:Signal):void
		{
			sendSignal(SignalPerformance.BEGIN_TEST);
		}
		
	}

}