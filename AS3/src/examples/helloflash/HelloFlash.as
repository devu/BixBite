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

package examples.helloflash 
{
	import examples.helloflash.transponder.BallTransponder;
	import examples.helloflash.model.HelloFlashModel;
	import examples.helloflash.view.MainView;
	import org.bixbite.core.Application;
	
	/**
	 * @version  compatibility - 0.4.4
	 * @since 0.4.0
	 * 
	 * This imlementation is based on Robotlegs HelloFlash example. To show you diferences in how we dealing with stuff.
	 * 
	 * Bixbite
	 * Footprint 5.62 kb, (core API 2.80 kb)
	 * 
	 * Robotlegs
	 * Footprint 16.7 kb
	 * 
	 * General coparison an conclusions:
	 * Bixbite
	 * +/- Original MVC paradigm. Considering popularity of other frameworks that treating MVC paradigm difrently it might be hard to change habbits.
	 *
	 * + Self registered system
	 * + Signal/Slot/Request notification system inspired by QT4
	 * + Signals are faster than native events
	 * + Signal reference mechanism will let you operate with local callback native speed.
	 * + Type safe API.
	 * + Completly loosely decoupled classes.
	 * + Less classes to get job done.
	 * + Smallest Footprint fully functional core has only 2.80 kb;
	 * + Much smaller memory consumption
	 * + Faster execution any part of the system.
	 * + Smallest startup lag.
	 * + Cleaner code.
	 * + Only 1 level of abstraction
	 * + The best framework for game developers and mobile platform in terms of performance.
	 *
	 * - Beta stage, not documented, not too many examples, no community behind it yet.
	 * - Dependency injection on architectual level only
	 * - More signals to broadcast in general due to loosely decoupled system.
	 * - Not unit testing yet.
	 
	 * Robotlegs
	 * +/- Break rules of Original MVC paradigm and moved logic/behaviour into commands fully controlled by Controllers. It might not be concidered as an issue. Is just the way it is. As long as rule of the game are clear and not abused by developers. 
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
	 * - To much influenced by PureMVC on architecture level.

	 */
	public class HelloFlash extends Application
	{
		
		public function HelloFlash() 
		{
			var c:BallTransponder 	= new BallTransponder();
			var v:MainView 			= new MainView();
			var m:HelloFlashModel 	= new HelloFlashModel();
			
			// And we're done ;)
		}
	}

}