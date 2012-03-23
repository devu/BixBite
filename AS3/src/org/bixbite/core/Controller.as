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
	import org.bixbite.core.interfaces.IController;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p><i>"The primary symptom of a controller is denial, that is I can’t see its symptoms in myself. — Keith Miller"</i></p>
     * <p>The Controller is an abstract class</p>
     * <p>Handles user input to change the state of the application, Interprets the mouse and keyboard inputs from the user, is mainly responsible for GUI logic, mediator between view and model, controls behaviour of the views and notify model with a signal system. 
	 * Following the rule "Keep Controllers skinny and Models fat". There is NO place in Controllers to handle business logic of the application due to original paradigm of MVC.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.4.4
     */
	public class Controller extends Actor implements IController 
	{
		private var emiter	:Emiter 	= Emiter.getInstance();
		private var slots	:Object 	= emiter.slots;
		
		use namespace BIXBITE
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function Controller() 
		{
			if (Object(this).constructor == Controller) throw new IllegalOperationError("Abstract Class");
		}
		
		/**
		 * Add Slot / register callbacks of specific type of signal and asociate them with Actors.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emiter.addSlot(slots.c, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister this specific actor from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emiter.removeSlot(slots.c, uid, type);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function sendSignal(type:String):void 
		{
			emiter.broadcast(slots.m, type, signal);
			emiter.broadcast(slots.v, type, signal);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	callback
		 */
		public function sendRequest(type:String, callback:Function):void
		{
			emiter.request(slots.m, type, signal, callback);
		}
		
		/**
		 * 
		 * @param	type
		 * @return
		 */
		public function getSlotReference(type:String):Array
		{
			return emiter.getSlot(slots.m, type);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emiter.removeAllSlotsOf(slots.c, uid);
			super.destroy();
		}
	}

}