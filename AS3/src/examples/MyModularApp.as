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
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.core.BixBite;
	import org.bixbite.framework.DisplayListManager;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.signal.StatsSignal;
	import org.bixbite.framework.StageManager;
	import org.bixbite.framework.Stats;
	
	/**
     * @version compatibility 0.5.4
     * @since 0.4.3
     * total footprint 12.2kb
     *
     * Purpose of this example is to show you true power of BixBite framework.
     * Due to architecture arrangement, Crystal pattern and Signal/Slot system that keeps all classes perfectly decoupled, let you create number of small functional applications (Compounds) and put them together in no time, to create brand new application.
     * This is very powerful feature. To addition to high-performance structure you can very quickly build entire application from early developed small applications and run them all at once as modules.
     * Then, this class become main application that will be a bridge between functional modules. 
	 * Going further, you can create another one app when this one will become a module!
	 * 
	 * NAMS - Nested Application Modular System
     *
     * We going to use all previously developed examples.
     */
    public class MyModularApp extends Sprite
    {
       
        public function MyModularApp()
        {
			addEventListener(Event.ADDED_TO_STAGE, init);
        }
		
		public function init(e:Event):void 
		{
			var bixbite:BixBite = new BixBite(stage);
			
			bixbite.register(StageManager);
			bixbite.sendSignal(StageManager.SET_STAGE, { align:"TL", scaleMode:"noScale" } );
			
			bixbite.register(DisplayListManager);
			
			bixbite.register(Stats);
			bixbite.sendSignal(StatsSignal.START);
			
			bixbite.register(HelloWorld);
			bixbite.register(HelloFlash);
		   
            //That's it!, all examples working in perfect harmony together.
		}
		
	}

}