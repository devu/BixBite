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