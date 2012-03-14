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
	import org.bixbite.core.interfaces.IController;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p><i>"The primary symptom of a controller is denial, that is I can’t see its symptoms in myself. — Keith Miller"</i></p>
     * <p>The Controller is an abstract class</p>
	 * <p>The controller interprets the mouse and keyboard inputs from the user, commanding the model and/or the view to change as appropriate.</p>
     * <p>Handles user input to change the state of the application, is mainly responsible for GUI logic, mediator between view and model, controls behaviour of the views and notify model with a signal system. 
	 * Also following the rule of "Keep Controllers skinny and Models fat". 
	 * There is NO place for controllers to handle business logic of the application due to original paradigm of MVC.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.2.10
     */
	public class Controller extends Actor implements IController 
	{
		private var _observer:Observer = Observer.getInstance();
		
		/**
         * <p>Constructor - this class cannot be directly instantiated. Internally constructor will set up basic and unique properties of the attached signal.
         * After this assignment is done will fire Actor's abstract method init() to make sure all settings are in place so in your sub-classed Object you can work with it having access to all data you need to be in place.</p>
         */
		public function Controller() 
		{
			if (Object(this).constructor == Controller) throw new IllegalOperationError("Abstract Class");
			init();
		}
		
		/**
         * <p>Standard method of broadcasting a signal across the system. Any actor with a slot added of certain signal type will react to it. This is multi-cast and asynchronous signal/slot system implementation.
         * You have to be aware that order of execution is unpredictable, if you need to take control over it, consider different signal types being executed one after another. And this is what you can control synchronously. 
		 * Priority implementation is not needed. Even if possible would sacrifice to much of performance benefits.</p>
         * 
		 * @param    type type of the signal as a String
         */
		public function sendSignal(type:String):void
		{
			_observer.sendSignal(type, signal);
		}
		
		/**
         * <p>This method is a direct method of sending signal when you expect immediate response from involved actor. As a result you will expect to get updated signal of responder that carry on some value informations.
         * In case of Controller that method will be used to notify any Model or even multiple Models, that having slot added of provided type of the signal.</p>
         *
         * @param    type, type of the signal as a String
         * @param    callback, listener function that will be triggered as soon as involved actor receive request.
         * @param    action, optional property let you perform different set of actions base on the same type of signal to avoid boiler-plate code and creating too many unique signal types / slots.
         */
		public function sendRequest(type:String, callback:Function, action:String = null):void
		{
			signal.BIXBITE::action = action;
			_observer.sendRequest(uid, type, signal, callback);
		}
		
		/**
         * <p>This method is a helper method that will give you references to all involved actors listening to particular signal type, without executing it. Use it for performance benefits in critical situations.
         * This way you have opportunity to execute calls with a native speed of accessing any local array. Nothing will be faster than that. If you have just few callbacks in returned array consider reference them directly as a functions, so the speed will equal exactly the speed of calling local method!
         * However, you have to remember, and this is your responsibility as developer, to kill references to it if no longer needed. Do not over use it.</p>
         *
         * @param   type type of the signal as a String
         * @return  array of the listeners attached to provided type of signal.
         */
		public function getSlotReferences(type:String):Array
		{
			return _observer.getSlotReferences(type)
		}
		
	}

}