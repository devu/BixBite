/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples 
{
	import examples.helloflash.HelloFlash;
	import examples.helloworld.HelloWorld;
	import examples.starling.HelloStarling;
	import starling.core.Starling;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.DisplayManager;
	import org.bixbite.framework.Stats;
	
	//import starling.core.Starling;
	//import starling.display.Sprite;
	
	/**
	 * @langversion	3.0
	 */
	public class MainExamples extends flash.display.Sprite
	{
		private var core0:Core;
		private var core1:Core;
		private var core2:Core;
		
		/**
		 * By default run all examples toogether, don't be terrified by the mess on the screen ;)
		 * comment/uncomment out examples if you like. Do this in random order to see adventage of modular structure of BixBite
		 */
		public function MainExamples() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			/*
			//Instatiate Starling for stage3D
			Starling.multitouchEnabled = true;
            Starling.handleLostContext = true;
			
			var starling:Starling = new Starling(starling.display.Sprite, stage);
            starling.simulateMultitouch  = false;
            starling.enableErrorChecking = false;
            starling.start();
			*/
			//Instantiate BixBite
			var bb:BixBite = new BixBite(stage);
			
			//Add some roots for display list, it can be any object that has addChild method implemented
			//bb.addContextRoot("stage", stage); is there by default
			bb.addContextRoot("root", this);
			core0 = bb.spawnCore("framework");
			core1 = bb.spawnCore("performance");
			/*
			bb.addContextRoot("stage2D", starling.stage);
			core2 = bb.spawnCore("starling");
			*/
			//Register functional Compounds with the Core
			/**
			 * Little Compound for basic stage management
			 */
			core0.register(DisplayManager);
			core0.emitSignal(DisplaySignal.SET_DISPLAY, { frameRate:60 } );
			
			/**
			 * Famous mrdoob Stats implemented within BixBite (currenlty as ready to go functional module of the framework);
			 */
			//core0.register(Stats);
			//core0.emitSignal(Stats.START);
			
			/**
			* Basic BixBite example to show workflow
			*/
			core1.register(HelloWorld);
			
			/**
			* Robot Legs Implementation of HelloFlash example whithin BixBite
			*/
			core1.register(HelloFlash);
			
			/**
			 * Example of Starling Integration
			 */
			//core2.register(HelloStarling);
		}
	}

}