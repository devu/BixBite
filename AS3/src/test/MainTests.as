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

package test 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.framework.Stats;
	import test.integration.contextloader.TestContextLoader;
	import test.performance.coreperf.CorePerformance;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * @langversion	3.0
	 */
	public class MainTests extends Sprite 
	{
		private var core1:Core;
		private var core2:Core;
		
		public function MainTests()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var bb:BixBite = new BixBite(stage);
			
			core1 = bb.spawnCore("stats");
			core1.register(Stats);
			core1.sendSignal(Stats.START);
			
			core2 = bb.spawnCore("test_case");
			//Signal performance test
			//core2.register(SignalPerformance);
			
			//Core performance test
			core2.register(CorePerformance);
		}
		
	}

}