/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.coreperf 
{
	import flash.system.System;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import test.performance.coreperf.view.TestViewA;
	import test.performance.coreperf.view.TestViewB;
	import test.performance.coreperf.view.TestViewC;
	
	import org.bixbite.core.Compound;
	
	import test.performance.coreperf.behaviour.TestBehaviour;
	import test.performance.coreperf.behaviour.TraceOutput;
	import test.performance.coreperf.data.TestData;
	import test.performance.coreperf.transponder.TestTransponder;
	import test.performance.coreperf.view.OutputView;
	
	/**
	 * @langversion	3.0
	 * footprint 11.0kb
	 * 
     * Purpose of this test is to keep track on speed of MVC actor creations. Since Bixbite is self-registered system there is much more going on under the hood.
     * During construction each Actor getting references to Emitter and getting default signal attached to it as well as unique identifier controlled by system.
     * During deconstruction (method destroy()) Object has to release all those references and clean up after itself.
     * Also Emitter always checking if there is empty slot will destroy it. This is why removal is always much slower.
     *
     * Taking under consideration all that, results below are still very satisfactory.
	 *  
	 * Results: See RESULTS.txt
	 */
	
	public class CorePerformance extends Compound
	{
		private var results		:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
		private var tasks		:Array = [];
		
		private var iterator	:int = 0;
		private var task		:int = 0;
		private var repeat		:int = 10;
		
		private var runner		:int;
		
		private var timeInterval:int = 200;
		
		public function CorePerformance() 
		{
			
		}
		
		override public function init():void 
		{
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
			
			tasks[33] = "reg/unreg Views+Ctx+Slot	1k";
			tasks[34] = "reg/unreg Views+Ctx+Slot	10k";
			tasks[35] = "reg/unreg Views+Ctx+Slot	100k";
			
			tasks[36] = "reg/unreg Views+Ctx+Gfx+Slot	1k";
			tasks[37] = "reg/unreg Views+Ctx+Gfx+Slot	10k";
			tasks[38] = "reg/unreg Views+Ctx+Gfx+Slot	100k";
			
			runner = setInterval(run, timeInterval);
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
					timeInterval = 1000;
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
					timeInterval = 10000;
					test12(1000, task);
					break;
				case 34:
					test12(10000, task);
					break;
				case 35:
					test12(100000, task);
					break;
				case 36:
					test13(1000, task);
					break;
				case 37:
					test13(10000, task);
					break;
				case 38:
					test13(100000, task);
					break;
				case 39:
					emitSignal("traceOutput", { id:40, row:"COMPLETE" } );
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
				
				timeInterval = parseInt(results[task]) / iterator + 100;
				runner = setInterval(run, timeInterval);
			}
			
			System.gc();
		}
		
		private function test1(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestViewA);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test2(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				unregister(TestViewA);
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
				register(TestViewA);
				unregister(TestViewA);
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
		
		private function test12(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestViewB);
				unregister(TestViewB);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function test13(max:int, resultsId:int):void 
		{
			var time:int = getTimer();
			for (var i:int = 0; i < max; i++) {
				register(TestViewC);
				unregister(TestViewC);
			}
			results[resultsId] += getTimer() - time;
		}
		
		private function output(id:int):void
		{
			emitSignal("traceOutput", { id:id, row:"TASK:" + tasks[id] + "			COUNT:"+ iterator + "	TIME:"+ Number(results[id] / (iterator + 1)).toPrecision(5) } );
		}
		
	}

}