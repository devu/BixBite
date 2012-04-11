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
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import org.bixbite.core.Compound;
	import org.bixbite.core.View;
	import org.bixbite.framework.modules.stageManager.StageManager;
	import org.bixbite.framework.modules.stageManager.transponder.StageTransponder;
	import org.bixbite.framework.modules.stats.Stats;
	import org.bixbite.framework.view.StageView;
	import test.performance.coreperf.model.TestModel;
	import test.performance.coreperf.transponder.TestTransponder;
	import test.performance.coreperf.view.TestView;
	
	/**
	 * @version  compatibility - 0.4.5
	 * @since 0.4.3
	 * footprint 9.53kb
	 * 
     * Purpose of this test is to keep track on speed of MVC actor creations. Since Bixbite is self-registered system there is much more going on under the hood.
     * During construction each Actor getting references to Emiter and getting default signal attached to it as well as unique identifier controlled by system.
     * During deconstruction (method destroy()) Object has to release all those references and clean up after itself.
     * Also Emiter always checking if there is empty slot will destroy it. This is why removal is always much slower.
     *
     * Taking under consideration all that, results below are still very satisfactory.
	 * 
	 * Results: (0.4.5)(Flash Player 11,1,102,63 - Chrome)
	 * TASK: create		Views	1.000	COUNT: 10	TIME: 1.182ms
	 * TASK: destroy	Views	1.000	COUNT: 10	TIME: 2.636ms
	 * TASK: create		Views	10.000	COUNT: 10	TIME: 11.64ms
	 * TASK: destroy	Views	10.000	COUNT: 10	TIME: 43.18ms
	 * TASK: create		Views	100k	COUNT: 10	TIME: 129.9ms
	 * TASK: destroy	Views	100k	COUNT: 10	TIME: 533.2ms
	 * 
	 * TASK: create		Trans	1.000	COUNT: 10	TIME: 1.000ms
	 * TASK: destroy	Trans	1.000	COUNT: 10	TIME: 6.455ms
	 * TASK: create		Trans	10.000	COUNT: 10	TIME: 10.55ms
	 * TASK: destroy	Trans	10.000	COUNT: 10	TIME: 52.18ms
	 * TASK: create		Trans	100k	COUNT: 10	TIME: 134.3ms
	 * TASK: destroy	Trans	100k	COUNT: 10	TIME: 354.0ms
	 * 
	 * TASK: create		Models	1.000	COUNT: 10	TIME: 1.000ms
	 * TASK: destroy	Models	1.000	COUNT: 10	TIME: 8.091ms
	 * TASK: create		Models	10.000	COUNT: 10	TIME: 11.36ms
	 * TASK: destroy	Models	10.000	COUNT: 10	TIME: 54.09ms
	 * TASK: create		Models	100k	COUNT: 10	TIME: 134.4ms
	 * TASK: destroy	Models	100k	COUNT: 10	TIME: 320.9ms
	 */
	
	public class CorePerformance extends Compound
	{
		private var results		:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
		private var tasks		:Array = [];
		
		private var iterator	:int = 0;
		private var task		:int = 0;
		private var repeat		:int = 10;
		
		private var testContainer	:Array = [];
		
		private var stats		:Stats;
		private var runner		:int;
		
		public function CorePerformance() 
		{
			var stageManager:StageManager = new StageManager();
			var stats:Stats = new Stats();
			
			tasks[0] = "create		Views	1.000";
			tasks[1] = "destroy	Views	1.000";
			tasks[2] = "create		Views	10.000";
			tasks[3] = "destroy	Views	10.000";
			tasks[4] = "create		Views	100k";
			tasks[5] = "destroy	Views	100k";
			
			tasks[6] = "create		Trans	1.000";
			tasks[7] = "destroy	Trans	1.000";
			tasks[8] = "create		Trans	10.000";
			tasks[9] = "destroy	Trans	10.000";
			tasks[10] = "create		Trans	100k";
			tasks[11] = "destroy	Trans	100k";
			
			tasks[12] = "create		Data	1.000";
			tasks[13] = "destroy	Data	1.000";
			tasks[14] = "create		Data	10.000";
			tasks[15] = "destroy	Data	10.000";
			tasks[16] = "create		Data	100k";
			tasks[17] = "destroy	Data	100k";
			
			runner = setInterval(run, 100);
		}
		
		private function run():void 
		{
			switch(task)
			{
				case 0:
					test1(1000, 0);
					sendTraceSignal(0);
					
					test2(1000, 1);
					sendTraceSignal(1);
					
					testContainer = [];
					break;
				case 1:
					test1(10000, 2);
					sendTraceSignal(2);
					
					test2(10000, 3);
					sendTraceSignal(3);
					
					testContainer = [];
					break;
				case 2:
					test1(100000, 4);
					sendTraceSignal(4);
					
					test2(100000, 5);
					sendTraceSignal(5);
					
					testContainer = [];
					break;
				case 3:
					test3(1000, 6);
					sendTraceSignal(6);
					
					test4(1000, 7);
					sendTraceSignal(7);
					
					testContainer = [];
					break;
				case 4:
					test3(10000, 8);
					sendTraceSignal(8);
					
					test4(10000, 9);
					sendTraceSignal(9);
					
					testContainer = [];
					break;
				case 5:
					test3(100000, 10);
					sendTraceSignal(10);
					
					test4(100000, 11);
					sendTraceSignal(11);
					
					testContainer = [];
					break;
				case 6:
					test3(1000, 12);
					sendTraceSignal(12);
					
					test4(1000, 13);
					sendTraceSignal(13);
					
					testContainer = [];
					break;
				case 7:
					test3(10000, 14);
					sendTraceSignal(14);
					
					test4(10000, 15);
					sendTraceSignal(15);
					
					testContainer = [];
					break;
				case 8:
					test3(100000, 16);
					sendTraceSignal(16);
					
					test4(100000, 17);
					sendTraceSignal(17);
					
					testContainer = [];
					break;
			}
			
			if (iterator < repeat){
				iterator++;
			} else {
				clearInterval(runner);
				iterator = 0;
				task++;
				switch(task)
				{
					case 1:
						runner = setInterval(run, 300);
						break;
					case 2:
						runner = setInterval(run, 1500);
						break;
					case 3:
						runner = setInterval(run, 100);
						break;
					case 4:
						runner = setInterval(run, 300);
						break;
					case 5:
						runner = setInterval(run, 1500);
						break;
					case 6:
						runner = setInterval(run, 100);
						break;
					case 7:
						runner = setInterval(run, 300);
						break;
					case 8:
						runner = setInterval(run, 1500);
						break;
					case 9:
						//stageView.attachSignal(new TraceSignal("TEST", "COMPLETE", 18));
						//stageView.sendSignal(StatsSignal.TRACE);
						break;
				}
			}
			
			System.gc();
		}
		
		private function sendTraceSignal(id:int):void
		{
			//stageView.attachSignal(new TraceSignal("TASK: " + tasks[id] + "		COUNT: " + iterator + "	TIME:", Number(results[id] / (iterator + 1)).toPrecision(4), id));
			//stageView.sendSignal(StatsSignal.TRACE);
		}
		
		private function test1(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				testContainer[i] = new TestView();
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test2(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				TestView(testContainer[i]).destroy();
				testContainer[i] = null;
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test3(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				testContainer[i] = new TestTransponder();
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test4(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				TestTransponder(testContainer[i]).destroy();
				testContainer[i] = null;
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test5(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				testContainer[i] = new TestModel();
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test6(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				TestModel(testContainer[i]).destroy();
				testContainer[i] = null;
			}
			results[resultsId] += getTimer() - time;
		}
		
	}

}