/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.display.Context;
	import org.bixbite.display.IDisplayList;
	import org.bixbite.display.NativeDisplayList;
	import org.bixbite.DisplayManager;
	import org.bixbite.signal.Display;
	import org.bixbite.Stats;
	import test.integration.leaktest.LeakTest;
	
	/**
	 * @langversion	3.0
	 */
	public class MainLeakTest extends Sprite 
	{
		private var bb:BixBite;
		
		private var core1:Core;
		private var core2:Core;
		
		public function MainLeakTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME, test);
			
			var root:IDisplayList = new NativeDisplayList(stage);
			
			bb = new BixBite(root);
			
			bb.addContext("app", new Context());
			bb.addContext("debug", new Context());
			
			core1 = bb.spawnCore("stats");
			
			core1.register(DisplayManager);
			core1.emitSignal(Display.SET_DISPLAY, { root:stage, frameRate:30 } );
			
			core1.register(Stats);
			core1.emitSignal(Stats.START, { root:stage } );
		}
		
		private function test(e:Event):void
		{
			var sMem:Number = System.totalMemory;
			
			//Create
			core2 = bb.spawnCore("leaktest");
			core2.register(LeakTest);
			core2.emitSignal("LeakTest.INIT");
			
			//destroy
			core2.unregister(LeakTest);
			bb.destroyCore("leaktest");
			
			System.pauseForGCIfCollectionImminent();
			System.gc();
			
			trace(System.totalMemory - sMem);
		}
		
	}

}