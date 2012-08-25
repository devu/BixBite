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
	import examples.hellodisplaylist.HelloDisplayList;
	import examples.helloflash.HelloFlash;
	import examples.helloworld.HelloWorld;
	import examples.imagegallery.ImageGallery;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.core.BixBite;
	import org.bixbite.framework.signal.StatsSignal;
	import org.bixbite.framework.Stats;
	
	/**
	 * @langversion	3.0
	 */
	public class MainExamples extends Sprite
	{
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
			var core:BixBite = new BixBite(stage);
			
			/**
			* Robot Legs Implementation of HelloFlash example whithin BixBite
			* footprint
			*/
			//core.register(HelloFlash);
			
			/**
			* Basic BixBite example to show workflow
			* footprint
			*/
			core.register(HelloWorld);
			
			/**
			 * Example of DisplayListManager use
			 */
			//core.register(HelloDisplayList);
			
			/**
			 * Example of Image Gallery
			 */
			//core.register(ImageGallery);
			//core.sendSignal(ImageGallery.INIT, { 
				//path:"http://www.bixbite.org/immagegallery/" 
			//} );
			
			/**
			 * Famous mrdoob Stats implemented within BixBite (currenlty as ready to go functional module of framework);
			 */
			//core.register(Stats);
			//core.sendSignal(StatsSignal.START);
		}
	}

}