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
			//bb.addContextRoot("stage2D", starling.stage);
			
			//Spawn some cores to work with and give it a name
			core0 = bb.spawnCore("framework");
			core1 = bb.spawnCore("performance");
			//core2 = bb.spawnCore("starling");
			
			//Register functional Compounds with the Core
			/**
			 * Little Compound for basic stage management
			 */
			core0.register(StageManager);
			core0.emitSignal(StageSignal.SET_STAGE, { frameRate:60 } );
			
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