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

package org.bixbite.core 
{
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.Actor;
	import org.bixbite.core.interfaces.IModel;
	
	/**
     * <p><i>"According to the standard model billions of years ago some little quantum fluctuation, perhaps a slightly
     * lower density of matter, maybe right where we’re sitting right now, caused our galaxy to start collapsing around here.
     * — Seth Lloyd"</i></p>
     *
     * <p>The Model contains the 'application data' AND 'business logic' to manage the STATE of the application. 
	 * Same way as you can't control laws of physics, you shouldn't try to put this responsibility into controllers. 
	 * You can control many objects that are under the defined laws of physics, but is the Model that defines them not Controller.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.2.9
     */
	public class Model extends Actor implements IModel
	{
		private var _observer:Observer = Observer.getInstance();
		
		/**
         * <p>Constructor - this class cannot be directly instantiated. Internally constructor will set up basic and unique properties of the attached signal.
         * After this assignment is done will fire Actor's abstract method init() to make sure all settings are in place so in your sub-classed Object you can work with it having access to all data you need to be in place.</p>
         */
		public function Model() 
		{
			if (Object(this).constructor == Model) throw new IllegalOperationError("Abstract Class");
			init();
		}
		
		/**
         * <p>Standard method of broadcasting a signal across the system. Any actor with a slot added of certain signal type will react to it. This is multi-cast and asynchronous signal/slot system implementation.
         * You have to be aware that order of execution is unpredictable, if you need to take control over it, consider different signal types being executed one after another. And this is what you can control synchronously. Priority implementation is not needed. Even if possible would sacrifice to much of performance benefits.</p>
         * @param    type type of the signal as a String
         */
		public function sendSignal(type:String):void
		{
			return _observer.sendSignal(type, signal);
		}
		
		/**
         * <p>This method is a helper method that will give you references to all involved actors listening to particular signal type, without executing it. Use it for performance benefits in critical situations.
         * This way you have opportunity to execute callback functions with a native speed of accessing any local array. Nothing will be faster than that. If you have just few callbacks in returned array consider reference them directly as a functions, so the speed will equal exactly the speed of calling local method!
         * However, you have to remember, and this is your responsibility as developer, to kill references to it if no longer needed. Do not over use it.</p>
         *
         * @param    type type of the signal as a String
         * @return  array of the listeners attached to provided type of signal.
         */
		public function getSlotReferences(type:String):Array
		{
			return _observer.getSlotReferences(type)
		}
		
	}

}