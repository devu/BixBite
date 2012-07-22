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
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.core.BixBite;
	
	/**
	 * @version  compatibility - 0.6.1
	 * @since 0.4.0
	 * 
	 * This implementation is based on RobotLegs HelloFlash example. To show you diferences in how we dealing with stuff.
	 * 
	 * Bixbite
	 * Footprint 5.22kb (was 0.5.5 - 6.58 kb)
	 * 
	 * Robotlegs
	 * Footprint 16.7 kb
	 * 
	 * General comparison an conclusions:
	 * Bixbite
	 * +/- CDTV paradigm (Compound, Data, Transponder, View). Considering popularity of other frameworks based on MVC paradigm it might be hard to change habbits.
	 *
	 * + Self registered system
	 * + Signal/Slot and Request/Response notification system inspired by QT4
	 * + Signals are faster than native events
	 * + SRS - Signal Reference System will let you operate with nearly local callback native speed.
	 * + Type safe API.
	 * + Completly loosely decoupled classes.
	 * + Less classes to get job done.
	 * + Smallest Footprint fully functional core has below 3.0 kb footprint.
	 * + Very low memory consumption
	 * + Faster execution of any part of the system.
	 * + Smallest startup lag.
	 * + Cleaner no boiler-plate code.
	 * + Only 1 level of abstraction
	 * + The best framework for game developers and mobile platform in terms of performance.
	 *
	 * - Beta stage, not documented, not too many examples, no community behind it yet.
	 * - Dependency injection on architectual level only
	 * - More signals to broadcast in general due to loosely decoupled system.
	 * - Not unit testing yet.
	 
	 * Robotlegs
	 * +/- Breaks rules of Original MVC paradigm and moved logic/behaviour into commands fully controlled by Controllers. 
	 * It might not be concidered as an issue. Is just the way it is. As long as rule of the game is clear and not abused by developers. 
	 *
	 * + Good support, active development and documentation.
	 * + Very well solves Dependency injection implementation. 
	 * + Very convinient for Unit testing.
	 * + Much cleaner and platform friendly solution than PureMVC.
	 * + Good number of developers familiar with framework.
	 * 
	 * - In some areas not type safe API.
	 * - More classes to get job done.
	 * - In Performance critical code this solution has dead end. Not efficient enought for Mobile and Game development.
	 * - Bigger footprint. 
	 * - Taking longer to compile.
	 * - In some cases performs even slower than PureMVC.
	 * - slowest communication system, relies on native Events.
	 * - easy to leak memory.
	 * - to much construction/deconstruction needed slowing system down.
	 * - Additional levels of abstraction to the MVC and manualy registered system forcing you to cross reference actors, this destroying loosely decoupled classes principal.
	 * - To much influenced by PureMVC on architecture level trying to compete with already overdone architecture by mimics it.

	 */
	public class MainHelloFlash extends Sprite
	{
		
		public function MainHelloFlash() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Initalise a core
			var core:BixBite = new BixBite(stage);
			
			//add Compound as Functional Module to the framework
			core.register(HelloFlash);
			
		}
	}

}