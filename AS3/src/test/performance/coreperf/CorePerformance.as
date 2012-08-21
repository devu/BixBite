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
	import test.performance.coreperf.behaviour.TestBehaviour;
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
		TASK:register	Views			10k			TIME:   1.00
		TASK:unregister	Views			10k			TIME:   2.00
		TASK:register	Views			100k		TIME:  17.00
		TASK:unregister	Views			100k		TIME:  22.00
		TASK:register	Views			1kk			TIME: 181.64
		TASK:unregister	Views			1kk			TIME: 235.45
		
		TASK:register	Trans			10k			TIME:   1.01
		TASK:unregister	Trans			10k			TIME:   2.00
		TASK:register	Trans			100k		TIME:  18.00
		TASK:unregister	Trans			100k		TIME:  23.27
		TASK:register	Trans			1kk			TIME: 198.91
		TASK:unregister	Trans			1kk			TIME: 259.00
		
		TASK:register	Data			10k			TIME:   1.01
		TASK:unregister	Data			10k			TIME:   2.00
		TASK:register	Data			100k		TIME:  19.00
		TASK:unregister	Data			100k		TIME:  25.00
		TASK:register	Data			1kk			TIME: 197.91
		TASK:unregister	Data			1kk			TIME: 261.45
		
		TASK:add/remove Behaviour		1k			TIME:   4.36
		TASK:add/remove Behaviour		10k			TIME:  54.91
		TASK:add/remove Behaviour		100k		TIME: 766.91
		TASK:add/exe/dispose Behaviour	1k			TIME:   4.82
		TASK:add/exe/dispose Behaviour	10k			TIME:  69.00
		TASK:add/exe/dispose Behaviour	100k		TIME: 831.09
		
		TASK:reg/unreg Views			1k			TIME:   9.90
		TASK:reg/unreg Views			10k			TIME: 107.55
		TASK:reg/unreg Views			100k		TIME: 991.00
		TASK:reg/unreg Trans			1k			TIME:   7.54
		TASK:reg/unreg Trans			10k			TIME:  83.18
		TASK:reg/unreg Trans			100k		TIME:1175.0
		TASK:reg/unreg Data				1k			TIME:   7.09
		TASK:reg/unreg Data				10k			TIME:  77.00
		TASK:reg/unreg Data				100k		TIME: 916.55
	 */
	
	public class CorePerformance extends Compound
	{
		private var results		:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
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
			
			tasks[18] = "add/remove Behaviour	1k";
			tasks[19] = "add/remove Behaviour	10k";
			tasks[20] = "add/remove Behaviour	100k";
			
			tasks[21] = "add/exe/dispose Behaviour	1k";
			tasks[22] = "add/exe/dispose Behaviour	10k";
			tasks[23] = "add/exe/dispose Behaviour	100k";
			
			tasks[24] = "reg/unreg Views	1k";
			tasks[25] = "reg/unreg Views	10k";
			tasks[26] = "reg/unreg Views	100k";
			
			tasks[27] = "reg/unreg Trans	1k";
			tasks[28] = "reg/unreg Trans	10k";
			tasks[29] = "reg/unreg Trans	100k";
			
			tasks[30] = "reg/unreg Data		1k";
			tasks[31] = "reg/unreg Data		10k";
			tasks[32] = "reg/unreg Data		100k";
			
			runner = setInterval(run, 500);
		}
		
		private function run():void 
		{
			System.gc();
			
			switch(task)
			{
				case 0:
					test1(10000, task);
					break
				case 1:
					test2(10000, task);
					break
				case 2:
					test1(100000, task);
					break
				case 3:
					test2(100000, task);
					break
				case 4:
					test1(1000000, task);
					break
				case 5:
					test2(1000000, task);
					break
				case 6:
					test3(10000, task);
					break;
				case 7:
					test4(10000, task);
					break;
				case 8:
					test3(100000, task);
					break;
				case 9:
					test4(100000, task);
					break;
				case 10:
					test3(1000000, task);
					break;
				case 11:
					test4(1000000, task);
					break;
				case 12:
					test5(10000, task);
					break;
				case 13:
					test6(10000, task);
					break;
				case 14:
					test5(100000, task);
					break;
				case 15:
					test6(100000, task);
					break;
				case 16:
					test5(1000000, task);
					break;
				case 17:
					test6(1000000, task);
					break;
				case 18:
					test7(1000, task);
					break;
				case 19:
					test7(10000, task);
					break;
				case 20:
					test7(100000, task);
					break;
				case 21:
					test8(1000, task);
					break;
				case 22:
					test8(10000, task);
					break;
				case 23:
					test8(100000, task);
					break;
				case 24:
					test9(1000, task);
					break;
				case 25:
					test9(10000, task);
					break;
				case 26:
					test9(100000, task);
					break;
				case 27:
					test10(1000, task);
					break;
				case 28:
					test10(10000, task);
					break;
				case 29:
					test10(100000, task);
					break;
				case 30:
					test11(1000, task);
					break;
				case 31:
					test11(10000, task);
					break;
				case 32:
					test11(100000, task);
					break;
				case 33:
					emitSignal("traceOutput", { id:33, row:"COMPLETE" } );
					clearInterval(runner);
					return
					break;
			}
			
			output(task);
			
			if (iterator < repeat){
				iterator++;
			} else {
				clearInterval(runner);
				iterator = 0;
				task++;
				runner = setInterval(run, 1000);
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
		
		private function test7(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				addBehaviour("testSignal", TestBehaviour);
				removeBehaviour("testSignal");
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test8(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				addBehaviour("testSignal", TestBehaviour, true, true);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test9(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestView);
				unregister(TestView);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test10(max:int, resultsId:int):void
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestTransponder);
				unregister(TestTransponder);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test11(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestData);
				unregister(TestData);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function output(id:int):void
		{
			emitSignal("traceOutput", { id:id, row:"TASK:" + tasks[id] + "			COUNT:"+ iterator + "	TIME:"+ Number(results[id] / (iterator + 1)).toPrecision(5) } );
		}
		
	}

}