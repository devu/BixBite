/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package  
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.display.Context;
	import org.bixbite.display.IDisplayList;
	import org.bixbite.display.NativeDisplayList;
	import org.bixbite.DisplayManager;
	import org.bixbite.signal.Display;
	import org.bixbite.Stats;
	import test.performance.coreperf.CorePerformance;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * @langversion	3.0
	 */
	public class MainTest extends Sprite 
	{
		private var core1:Core;
		private var core2:Core;
		private var core3:Core;
		private var core4:Core;
		private var loader:Loader;
		
		public function MainTest()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//check if bixbite can be loaded from outside.
			//don't worry about following tests, they will run :)
			//loadBixBiteFromFile();
			
			var root:IDisplayList = new NativeDisplayList(stage);
			
			var bb:BixBite = new BixBite(root);
			
			bb.addContext("app", new Context());
			bb.addContext("debug", new Context());
			
			core1 = bb.spawnCore("stats");
			
			core1.register(DisplayManager);
			core1.emitSignal(Display.SET_DISPLAY, { root:stage, frameRate:30 } );
			
			core1.register(Stats);
			core1.emitSignal(Stats.START, { root:stage } );
			
			core2 = bb.spawnCore("test_cases");
			
			//Signal performance test
			core2.register(SignalPerformance);
			
			//Core performance test
			//core2.register(CorePerformance);
			
			//Multicore communication test
			/*
			core3 = bb.spawnCore("test_core_1");
			core3.register(CoreCompoundOne);
			core2.register(CoreCompoundTwo);
			*/
		}
		/*
		private function loadBixBiteFromFile():void 
		{
			//local
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			//on the server
			//var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(new URLRequest("bixbite.swf"), loaderContext);
		}
		
		private function onLoadComplete(e:Event):void 
		{
			trace("bixbite module loaded");
			addChild(loader.content);
		}*/
		
	}

}