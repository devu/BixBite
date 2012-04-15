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

package examples.mudularstructure 
{
	import examples.helloflash.HelloFlash;
	import examples.helloworld.MainHelloWorld;
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.stats.Stats;
	
	/**
     * @version compatibility 0.5.1
     * @since 0.4.3
     * total footprint 10.7kb
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
    public class MyApplication extends Compound
    {
       
        public function MyApplication()
        {
            var helloworld   :MainHelloWorld 	= new MainHelloWorld();
            var helloflash   :HelloFlash     	= new HelloFlash();
            var stats        :Stats      		= new Stats();
		   
            //That's it!, all examples working in perfect harmony together.
        }
       
        /**
         * Now, this is something worth consideration. Each functional Compound might have some public methods exposed to control internal functional modules.
         * This way you can easily provide some API for your modules, than can be controlled from main Compound/Application directly.
         * However indirectly you can still use Signals to even keep your modules decoupled!
         *
         * BixBite framework assuming this is perfectly fine to use both ways in this case.
         * You need to consider yourself what better suits you for development purposes.
         */
        public function exposedModuleMethod():void
        {
            //For instance you could do this:
			//helloworld.exposedModuleMethod();
			//helloflash.exposedModuleMethod();
			//stats.exposedModuleMethod();
        }
		
	}

}