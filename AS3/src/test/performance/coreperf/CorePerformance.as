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
	 * Results: 
	 
		0.6.3	(Flash Player 11,1,102,63 - Chrome) max Mem 8.873 MB													
		0.8.0 	(Flash PLayer 11,5,31,101 - Chrome) max Mem 4.615 MB
		0.9.1 	(Flash PLayer 11,5,31,101 - Chrome) Mem min/max on test complete 20/9 MB
		Android	Google Nexus S, 2 years old, single core, BixBite 0.9.1 browser-plugin ( No longer supported )
		
		footprint 13.7kb
		All timing in ms
		
		versions									0.6.3	 0.8.0	   0.9.1 	Android
		TASK:register	Views			10k			 1.00	  1.20		1.09	  54.81
		TASK:unregister	Views			10k			 2.00	  2.18	    2.00	  73.90
		TASK:register	Views			100k		17.00	 20.45	   19.00	 320.45
		TASK:unregister	Views			100k		22.00	 26.90	   23.00	 464.36
		TASK:register	Views			1kk		   181.64	216.82	  197.55	2999.40
		TASK:unregister	Views			1kk		   235.45	271.55	  246.91	4248.50
		
		TASK:register	Trans			10k			 1.01	  1.18 	    1.09	  57.27
		TASK:unregister	Trans			10k			 2.00	  2.00		2.00	  82.09
		TASK:register	Trans			100k		18.00	 19.90	   19.00	 344.09
		TASK:unregister	Trans			100k		23.27	 26.00	   23.00	 464.00
		TASK:register	Trans			1kk		   198.91	207.82	  196.36	3136.10
		TASK:unregister	Trans			1kk		   259.00	269.55	  243.91	4430.60
		
		TASK:register	Data			10k			 1.01	  1.09		1.09	  63.81
		TASK:unregister	Data			10k			 2.00	  2.00		2.00	  72.81
		TASK:register	Data			100k		19.00	 20.00	   19.00	 345.09
		TASK:unregister	Data			100k		25.00	 25.00	   23.81	 489.09
		TASK:register	Data			1kk		   197.91	208.91	  197.91	3151.80
		TASK:unregister	Data			1kk		   261.45	265.45 	  243.64	4371.70
		
		TASK:add/remove Behaviour		1k			 4.36	  3.09 	    3.18	  95.72
		TASK:add/remove Behaviour		10k			54.91	 39.00 	   37.45	 721.55
		TASK:add/remove Behaviour		100k		766.91	402.18    387.82	6939.80
		
		TASK:add/exe/dispose Behaviour	1k			4.82	  4.27 		3.09	 100.73
		TASK:add/exe/dispose Behaviour	10k			69.00	 42.45 	   39.36	 763.64
		TASK:add/exe/dispose Behaviour	100k		831.09	417.91 	  403.45	7854.50
		
		TASK:reg/unreg Views			1k			  9.90	  2.09	  	2.00	  61.81
		TASK:reg/unreg Views			10k			107.55	 27.36	   24.54	 418.91
		TASK:reg/unreg Views			100k		991.00	271.55 	  251.82 	3601.00
		TASK:reg/unreg Trans			1k			  7.54	  2.90		2.09	  68.27
		TASK:reg/unreg Trans			10k			 83.18	 28.90	   27.00	 413.18
		TASK:reg/unreg Trans			100k		1175.0	297.09 	  276.27	4077.50
		TASK:reg/unreg Data				1k			  7.09	  2.00		2.00	  60.18
		TASK:reg/unreg Data				10k			 77.00	 21.72	   20.63	 377.18
		TASK:reg/unreg Data				100k		916.55	219.91 	  208.36	 3001.9
		
		//Overloaded with real tasks
		TASK:reg/unreg Views+Ctx+Slot		1k						   15.54	 275.55
		TASK:reg/unreg Views+Ctx+Slot		10k						  164.45	2531.40
		TASK:reg/unreg Views+Ctx+Slot		100k				 	 1663.80   25854.00
		
		//Overloaded with real tasks and graphics
		TASK:reg/unreg Views+Ctx+Gfx+Slot	1k						   19.91	 307.82
		TASK:reg/unreg Views+Ctx+Gfx+Slot	10k						  202.00	2894.90
		TASK:reg/unreg Views+Ctx+Gfx+Slot	100k					 2012.50   28350.00
	 */
	
	public class CorePerformance extends Compound
	{
		private var results		:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
		private var tasks		:Array = [];
		
		private var iterator	:int = 0;
		private var task		:int = 0;
		private var repeat		:int = 10;
		
		private var runner		:int;
		
		private var timeInterval:int = 2000;
		
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