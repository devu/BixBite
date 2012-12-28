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

package test 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
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
			bb.addContextRoot("stage", stage);
			
			core1 = bb.spawnCore("stats");
			
			core1.register(StageManager);
			core1.emitSignal(StageSignal.SET_STAGE, { frameRate:30 } );
			
			core1.register(Stats);
			core1.emitSignal(Stats.START);
			
			core2 = bb.spawnCore("test_cases");
			
			//Signal performance test
			core2.register(SignalPerformance);
			
			//Core performance test
			//core2.register(CorePerformance);
			
			//Multicore communication test
			/*
			core3 = bb.spawnCore("test_core_1");
			core3.register(CoreCompoundOne);
			
			core4 = bb.spawnCore("test_core_2");
			core4.register(CoreCompoundTwo);
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