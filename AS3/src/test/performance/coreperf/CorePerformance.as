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

package test.performance.coreperf 
{
	import flash.system.System;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import org.bixbite.core.Compound;
	import org.bixbite.framework.signal.StatsSignal;
	import org.bixbite.framework.Stats;
	import test.performance.coreperf.behaviour.TraceOutput;
	import test.performance.coreperf.data.TestData;
	import test.performance.coreperf.transponder.TestTransponder;
	import test.performance.coreperf.view.OutputView;
	import test.performance.coreperf.view.TestView;
	
	
	/**
	 * @langversion	3.0
	 * footprint 11.0kb
	 * 
     * Purpose of this test is to keep track on speed of MVC actor creations. Since Bixbite is self-registered system there is much more going on under the hood.
     * During construction each Actor getting references to Emiter and getting default signal attached to it as well as unique identifier controlled by system.
     * During deconstruction (method destroy()) Object has to release all those references and clean up after itself.
     * Also Emiter always checking if there is empty slot will destroy it. This is why removal is always much slower.
     *
     * Taking under consideration all that, results below are still very satisfactory.
	 * 
	 * Results: (0.6.3) CDTV (Flash Player 11,1,102,63 - Chrome) footprint 11.0kb
	 * 
	 * TASK:register	Views	10k		AVG TIME:1.091
	 * TASK:unregister	Views	10k		AVG TIME:1.000
	 * TASK:register	Views	100k	AVG TIME:17.00
	 * TASK:unregister	Views	100k	AVG TIME:17.00
	 * TASK:register	Views	1kk		AVG TIME:173.9
	 * TASK:unregister	Views	1kk		AVG TIME:173.7
	 * Same for Trans and Data
	 */
	
	public class CorePerformance extends Compound
	{
		private var results		:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
		private var tasks		:Array = [];
		
		private var iterator	:int = 0;
		private var task		:int = 0;
		private var repeat		:int = 10;
		
		private var runner		:int;
		
		public function CorePerformance() 
		{
			
		}
		
		override public function init():void 
		{
			register(Stats)
			sendSignal(StatsSignal.START);
			
			register(OutputView);
			addBehaviour("traceOutput", TraceOutput);
			
			tasks[0] = "register	Views	10k";
			tasks[1] = "unregister	Views	10k";
			tasks[2] = "register	Views	100k";
			tasks[3] = "unregister	Views	100k";
			tasks[4] = "register	Views	1kk";
			tasks[5] = "unregister	Views	1kk";
			
			tasks[6] = "register	Trans	10k";
			tasks[7] = "unregister	Trans	10k";
			tasks[8] = "register	Trans	100k";
			tasks[9] = "unregister	Trans	100k";
			tasks[10] = "register	Trans	1kk";
			tasks[11] = "unregister	Trans	1kk";
			
			tasks[12] = "register	Data	10k";
			tasks[13] = "unregister	Data	10k";
			tasks[14] = "register	Data	100k";
			tasks[15] = "unregister	Data	100k";
			tasks[16] = "register	Data	1kk";
			tasks[17] = "unregister	Data	1kk";
			
			runner = setInterval(run, 500);
		}
		
		private function run():void 
		{
			var iterations:int;
			
			switch(task)
			{
				case 0:
				case 1:
				case 6:
				case 7:
				case 12:
				case 13:
					iterations = 10000;
					break;
				case 2:
				case 3:
				case 8:
				case 9:
				case 14:
				case 15:
					iterations = 100000;
					break;
				case 4:
				case 5:
				case 10:
				case 11:
				case 16:
				case 17:
					iterations = 1000000;
					break;
			}
			
			test1(iterations, task);
			output(task);
			
			if (iterator < repeat){
				iterator++;
			} else {
				clearInterval(runner);
				iterator = 0;
				task++;
				
				if(task == 18){
					trace( "COMPLETE" );
				} else {
					runner = setInterval(run, 500);
				}
			}
			
			System.gc();
		}
		
		private function test1(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestView);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test2(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				unregister(TestView);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test3(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestTransponder);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test4(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				unregister(TestTransponder);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test5(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestData);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test6(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				unregister(TestData);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function output(id:int):void
		{
			emitSignal("traceOutput", { id:id, row:"		TASK:" + tasks[id] + "		COUNT:"+ iterator + "		TIME:"+ Number(results[id] / (iterator + 1)).toPrecision(4) } );
		}
		
	}

}