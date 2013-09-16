/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import org.bixbite.core.ContextContainer;
	
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.DisplayManager;
	import org.bixbite.framework.Stats;
	
	import test.integration.multicore.CoreCompoundOne;
	import test.integration.multicore.CoreCompoundTwo;
	import test.performance.coreperf.CorePerformance;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * @langversion	3.0
	 */
	public class MainTests extends Sprite 
	{
		private var core1:Core;
		private var core2:Core;
		private var core3:Core;
		private var core4:Core;
		private var loader:Loader;
		
		public function MainTests()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//check if bixbite can be loaded from outside.
			//don't worry about following tests, they will run :)
			//loadBixBiteFromFile();
			
			var bb:BixBite = new BixBite(stage);
			
			bb.addContainer("app", new ContextContainer());
			bb.addContainer("debug", new ContextContainer());
			
			core1 = bb.spawnCore("stats");
			
			core1.register(DisplayManager);
			core1.emitSignal(DisplaySignal.SET_DISPLAY, { frameRate:30 } );
			
			core1.register(Stats);
			core1.emitSignal(Stats.START);
			
			core2 = bb.spawnCore("test_cases");
			
			//Signal performance test
			core2.register(SignalPerformance);
			
			//Core performance test
			core2.register(CorePerformance);
			
			//Multicore communication test
			/*
			core3 = bb.spawnCore("test_core_1");
			core3.register(CoreCompoundOne);
			core2.register(CoreCompoundTwo);
			*/
		}
		
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
		}
		
	}

}