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
	import org.bixbite.core.Emiter;
	import org.bixbite.core.interfaces.IActor;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The Actor is a abstract base class for all the mebers of the MVC triad.</p>
	 * 
	 * <p>Purpose of this class is to provide unified way to register the member within Signal Emiter, get unique id and attach default signal into it. As well as provide common set of signal/slot methods for communication</p>
	 *
	 * @langversion	3.0
	 * @version 0.4.1
	 */
	public class Actor implements IActor
	{
		/**
		 * @private
		 * Every Actor will invoke this assigment in order to get short reference to Emiter.
		 */
		private var _emiter	:Emiter 	= Emiter.getInstance();
		
		/**
		 * @private
		 * Every Actor will get short reference to SystemIO, in case of AS3 implementation relies mostly on native stage. 
		 * This assigment will make system available even before constructor of this class is invoked.
		 */
		private var _system		:SystemIO 	= _emiter.system;
		
		/**
		 * @private
		 * Base on Emiter short reference, evey Actor will get unique id from observer uid iterator.
		 */
		private var _uid		:String		= "@" + _emiter.uid;
		
		/**
         * Reference to default Signal attached to its Actor. It can be reattached from subclass by using attachSignal method by passing Custom Signal implementation into it.
         * However direct access to this reference is provided via ISignal interface. Since only necessary set of interface methods are controlled by system.
         * In receiver of particular signal if you know the type of the Custom Signal you expecting to recieve, you can use concrete class name of the Signal in signature to avoid unnecessary castings and access values directly;
         */
		public var signal		:ISignal 	= attachSignal();
		
		/**
		 * Use system default namespace
		 */
		use namespace BIXBITE;
		
		/**
		 * Constructor, Actor is an abstract class, cannot be directly instatiated. 
		 */
		public function Actor()
		{
			if (Object(this).constructor == Actor) throw new IllegalOperationError("Abstract Class");
		}
		
		/**
		 * Abstract method init must be overriden in subclasses. 
		 * Is not directly triggered by Actor class but by MVC specific subclasses to ensure all assigments are in place.
		 */
		public function init():void
		{
			throw new IllegalOperationError("Abstract Method");
		}
		
		/**
		 * Deconstructor of an Actor. 
		 * Will detach/unregister all registered signals form Emiter and clear all nesesary references.
		 * Subclasses should override this method and call super.destroy();.
		 * On Subclass level you don't have to care about signal removal, only references of the objects you have created.
		 */
		public function destroy():void
		{
			_emiter.removeAllSlotsOf(this, _uid);
			_emiter = null;
			_system = null;
			
			signal.dispose();
			signal = null;
			_uid = null;
		}
		
		/**
		 * Method to set default signal attached to Actor, that will be later on send within Signal/Slot system.
		 * If not set, basic Signal will be constructed by default.
		 */
		public function attachSignal(signal:ISignal = null):ISignal
		{
			if (!signal) signal = new Signal();
			else this.signal.dispose();
			
			signal.BIXBITE::callerUID = uid;
			this.signal = signal;
			
			return signal;
		}
		
		/**
		 * Add Slot / register callbacks of specific type of signal and asociate them with Actors.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			_emiter.addSlot(this, _uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister this specific actor from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			_emiter.removeSlot(this, _uid, type);
		}
		
		/**
		 * This method will remove entire slot of specific type, no matter witch actor is calling all registered acctors will stop recieveing those signals
		 * @param	type
		 */
		public function removeAllSlots(type:String):void
		{
			_emiter.removeAllSlots(this, type);
		}
		
		/**
         * <p>Standard method of broadcasting a signal across the system. Any actor with a slot added of certain signal type will react to it. This is multi-cast and asynchronous signal/slot system implementation.
         * You have to be aware that order of execution is unpredictable, if you need to take control over it, consider different signal types being executed one after another. And this is what you can control synchronously. 
		 * 'Priority' implementation is not needed. Even if possible would sacrifice to much of performance benefits.</p>
         * @param   type, type of the signal as a String
		 * @param 	customSignal, optional param if you need to send occasionaly some custom signal that is not attached to Actor.
         */
		public function sendSignal(type:String):void
		{
			_emiter.sendSignal(this, type, signal);
		}
		
		/**
         * <p>Direct method of sending signal when you expect immediate response from involved actor. As a result you will expect to get updated signal of responder that carry on some value informations.
         * In case of <code>Controller</code> that method will be used to notify any <code>Model</code> or even multiple Models, that having slot added of provided type of the signal.</p>
         *
         * @param    type, type of the signal as a String
         * @param    callback, optional listener function that will be triggered as soon as involved actor receive request.
         * @param    acton, optional property let you perform different set of actions base on the same type of signal to avoid boiler-plate code and to many unique signal types / slots.
         */
		public function sendRequest(type:String, callback:Function = null, action:String = null):void
		{
			signal.BIXBITE::action = action;
			_emiter.sendRequest(this, type, signal, callback);
		}
		
		/**
         * <p>This method is a helper method that will give you references to all involved actors listening to particular signal type, without executing it. Use it for performance benefits in critical situations.
         * This way you have opportunity to execute calls with a native speed of accessing any local array. Nothing will be faster than that. If you have just few callbacks in returned array consider reference them directly as a Functions, so the speed will equal exactly the speed of calling local method!
         * However, you have to remember, and this is your responsibility as developer, to kill references to it if they are no longer needed. Do not over use it.</p>
         *
         * @param   type type of the signal as a String
         * @return  array of the listeners attached to provided type of signal.
         */
		public function getSlotReferences(type:String):Array
		{
			return _emiter.getSlotReferences(this, type);
		}
		
		/**
		 * Reference to System I/O
		 */
		public function get system():SystemIO 
		{
			return _system;
		}
		
		/**
		 * Unique actor identifier
		 */
		public function get uid():String 
		{
			return _uid;
		}
		
		/**
		 * @private
		 * Unique actor identifier controlled by Emiter
		 * @param	uid
		 */
		BIXBITE function setUID(uid:String):void
		{
			_uid = uid;
		}
		
	}

}