/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples 
{
	import examples.helloflash.HelloFlash;
	import examples.helloworld.HelloWorld;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.display.Context;

	import org.bixbite.signal.Display;
	import org.bixbite.Stats;
	
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.display.IDisplayList;
	import org.bixbite.display.NativeDisplayList;
	import org.bixbite.DisplayManager;
	
	/**
	 * @langversion	3.0
	 */
	public class MainExamples extends Sprite
	{
		private var core0:Core;
		private var core1:Core;
		
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
			
			var root:IDisplayList = new NativeDisplayList(stage);
			
			var bb:BixBite = new BixBite(root);
			
			//Add some roots for display list.
			bb.addContext("app", new Context());
			bb.addContext("debug", new Context());
			
			core0 = bb.spawnCore("examples");
			core1 = bb.spawnCore("performance");
			
			//Register functional Compounds with the Core
			/**
			 * Little Compound for basic stage management
			 */
			core0.register(DisplayManager);
			core0.emitSignal(Display.SET_DISPLAY, { root:stage, frameRate:60 } );
			
			/**
			 * Famous mrdoob Stats implemented within BixBite (currenlty as ready to go functional module of the framework);
			 */
			core0.register(Stats);
			core0.emitSignal(Stats.START, { root:stage } );
			
			/**
			* Basic BixBite example to demonstrate the workflow
			*/
			core1.register(HelloWorld);
			
			/**
			* RobotLegs Implementation of HelloFlash example whithin BixBite
			*/
			core1.register(HelloFlash);
		}
	}

}