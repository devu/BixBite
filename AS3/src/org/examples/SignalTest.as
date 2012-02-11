package org.examples 
{
	import flash.display.Sprite;
	import flash.sampler.getSize;
	import flash.system.System;
	import flash.utils.getTimer;
	import org.examples.controller.TestControllerBeta;
	
	import org.bixbite.framework.core.Application;
	
	import org.examples.controller.TestController;
	import org.examples.model.TestModel;
	import org.examples.signals.ValueObject;
	import org.examples.view.TestView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class SignalTest extends Application 
	{
		
		public function SignalTest():void
		{
			
			// One to many 'TestView' case scenario
			
			// With drawings
			// iterations 	STARTUP		TEST	FREE MEM		TOTAL MEM
			// 1.000		13			3		6.540 	kb		4.700 	kb
			// 10.000		111			27		10.892 	kb		9.048 	kb
			// 100.000		1421		280		55.956 	kb		54.036 	kb
			
			// Just signals (view is not on the stage)
			// iterations 	STARTUP		TEST	FREE MEM		TOTAL MEM
			// 1.000		10			0		6.412 	kb		4.600 	kb
			// 10.000		76			3		10.384 	kb		8.620 	kb
			// 100.000		1068		31		53.908 	kb		52.068 	kb
			// 1.000.000	35192		309		509.704 kb		506.876 kb
			
			// 1 signal sent to 3.700,000 views per second!
			
			// Many to one
			
			// Just signals (view is not on the stage)
			// STARTUP 		- 2ms
			// FREE MEM 	- 6.148 	kb
			// FREE MEM 	- 4.316  	kb
			
			// iterations 	TEST	NO PARAM(just notification)
			// 1.000		5		4
			// 10.000		47		47
			// 100.000		475		470
			
			// one signal sent N number of times, only one view listening
			
			// Many to Many
			// 10s 		* 100v 	0 ms		(1.000)
			// 100s 	* 10v 	0 ms		(1.000)
			// 100s 	* 100v 	3 ms		(10.000)
			// 1000s 	* 100v 	30 ms		(100.000)
			// 100s 	* 1000v 27 ms		(100.000)
			// 1000s 	* 1000v 273 ms		(1.000.000)
			
			// as you can see, it is very scalable, number of signals * number of recievers
			// 100.000 is acceptable but 30ms might result with visible GUI LAG since this is average render time cycle
			
			// - to compare to Event System.
			// Events in one-to-many are much much slower (around 8x)
			// many-to-one, comparable but results are not stable, but in many-to-many combination of both will never bit signals
			// in one-to-many test, signals shows only 20% slowdown to compare to callbacks, but benefits from perfectly decoupled actors are bigger than anything else
			// Signals/Slots have also much less impact for memory consumption and will not lead to boilerplate-code
		}
		
		override public function init():void
		{
			
		}
		
		override public function create():void 
		{
			var start:int = getTimer();
			
			new TestModel();
			
			//one-to-many
			new TestController(stage);
			for (var i:int = 0; i < 1000; i++) addView(new TestView());
			
			//many-to-one
			//new TestControllerBeta(stage);
			//new TestView()
			
			//many-to-many
			//new TestControllerBeta(stage);
			//for (var i:int = 0; i < 100; i++) new TestView();
			
			trace("MEM USAGE", getSize(this));
			trace("STARTUP", getTimer() - start );
			trace("FREE MEM", System.privateMemory/1024 );
			trace("TOTAL MEM", System.totalMemoryNumber/1024 );
			
		}
		
	}
	
}