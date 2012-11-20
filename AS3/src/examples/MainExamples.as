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

package examples 
{
	import examples.contextloader.ContextLoaderExample;
	import examples.hellodisplaylist.HelloDisplayList;
	import examples.helloflash.HelloFlash;
	import examples.helloworld.HelloWorld;
	import examples.starling.HelloStarling;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	import org.bixbite.framework.Stats;
	
	
	/**
	 * @langversion	3.0
	 */
	public class MainExamples extends Sprite
	{
		private var core0:Core;
		private var core1:Core;
		private var core2:Core;
		
		/**
		 * Uncomment out example in order to run it.
		 * Uncomment them all or in random order to see adventage of modular structure of BixBite
		 */
		public function MainExamples() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/**
			* Initalise a core
			*/
			var bb:BixBite = new BixBite(stage);
			core0 = bb.spawnCore("framework");
			core1 = bb.spawnCore("performance");
			core2 = bb.spawnCore("starling");
			
			/**
			 * Famous mrdoob Stats implemented within BixBite (currenlty as ready to go functional module of the framework);
			 */
			
			core0.register(StageManager);
			core0.sendSignal(StageSignal.SET_STAGE, { frameRate:60 } );
			
			core1.register(Stats);
			core1.sendSignal(Stats.START);
			
			/**
			* Robot Legs Implementation of HelloFlash example whithin BixBite
			*/
			//core1.register(HelloFlash);
			
			/**
			* Basic BixBite example to show workflow
			*/
			//core1.register(HelloWorld);
			
			/**
			 * Example of DisplayListManager use
			 */
			//core1.register(HelloDisplayList);
			
			/**
			 * Example of Starling Integration
			 */
			core2.register(HelloStarling);
			
			/*
			 * TODO
			 */
			//core1.register(ContextLoaderExample);
		}
	}

}