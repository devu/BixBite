/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.signalperf.behaviour 
{
	
	import flash.events.Event;
	import flash.utils.getTimer;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * This is equivalent of signal test represented native way. 
	 * We have been trying to avoid bubbeling and nested objects and make as simple shallow structure as possible.
	 * @langversion 3.0
	 */
	public class NativeTest extends Behaviour 
	{
		private var objectA:ObjectA;
		private var objectB:ObjectB;
		private var objectC:ObjectC;
		
		override public function init():void 
		{
			objectA = new ObjectA();
			objectA.addEventListener("eventTestA", onEventA);
			objectB = new ObjectB();
			objectB.addEventListener("eventTestB", onEventB);
			objectC = new ObjectC();
			objectC.addEventListener("eventTestC", onEventC);
		}
		
		override public function execute(s:Signal):void
		{
			var max:int = s.params.max;
			var time:int = getTimer();
			for (var i:int = 0 ; i < max; i++) objectA.dispatchEvent(new Event("eventTestA"));
			time = getTimer() - time;
			
			sendSignal(SignalPerformance.NATIVE_TEST_RESULTS, { time:time } );
			emitSignal(SignalPerformance.BEGIN_CALLBACK_TEST, { max:max } );
		}
		
		private function onEventA(e:Event):void 
		{
			objectB.dispatchEvent(new Event("eventTestB"));
		}
		
		private function onEventB(e:Event):void 
		{
			objectC.dispatchEvent(new Event("eventTestC"));
		}
		
		private function onEventC(e:Event):void 
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