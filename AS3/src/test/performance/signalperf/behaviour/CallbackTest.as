/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.signalperf.behaviour 
{
	
	import flash.utils.getTimer;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * This is equivalent of signal test represented native way as pure callback crossreferenced structure. 
	 * @langversion 3.0
	 */
	public class CallbackTest extends Behaviour 
	{
		private var objectA:ObjectA;
		private var objectB:ObjectB;
		private var objectC:ObjectC;
		
		override public function init():void 
		{
			objectA = new ObjectA();
			objectA.onEventTestA = onEventA;
			objectB = new ObjectB();
			objectB.onEventTestB = onEventB;
			objectC = new ObjectC();
			objectC.onEventTestC = onEventC;
		}
		
		override public function execute(s:Signal):void
		{
			var max:int = s.params.max;
			
			var time:int = getTimer();
			for (var i:int = 0 ; i < max; i++) objectA.onEventTestA();
			time = getTimer() - time;
			
			sendSignal(SignalPerformance.CALLBACK_TEST_RESULTS, { time:time } );
		}
		
		private function onEventA():void 
		{
			objectB.onEventTestB();
		}
		
		private function onEventB():void
		{
			objectC.onEventTestC();
		}
		
		private function onEventC():void
		{
			//trace("recieved");
		}
		
		override public function dispose():void 
		{
			//clean up this class here and then:
			super.dispose();
		}
		
	}
	
}