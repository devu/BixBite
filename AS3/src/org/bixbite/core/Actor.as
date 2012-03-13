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
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.interfaces.IActor;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Observer;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The Actor is a abstract base class for all the mebers of the MVC triad.</p>
	 * 
	 * <p>Purpose of this class is to provide unified way to register the member within Observer pattern, get unique id and attach default signal into it. As well as provide common set of signal/slot methods for communication</p>
	 *
	 * @langversion	3.0
	 * @version 0.2.9
	 */
	public class Actor implements IActor
	{
		/**
		 * Every Actor will invoke this assigment in order to get short reference to observer.
		 */
		private var _observer	:Observer 	= Observer.getInstance();
		
		/**
		 * Every Actor will get short reference to system I/O, in case of AS3 implementation is a native stage. 
		 * This assigment will make stage it available even before constructor of this class is invoked.
		 */
		private var _stage		:Stage 		= _observer.stage;
		
		/**
		 * Base on observer short reference, evey Actor will get unique id from observer uid iterator.
		 */
		private var _uid		:String		= "@"+_observer.uid;
		
		/**
         * Reference to default Signal attached to its Actor. It can be reattached from subclass by using attachSignal method by passing Custom Signal implementation into it.
         * However direct access to this reference is provided via Signal interface ISignal. Since only necessary set of interface methods are controlled by system.
         * In receiver of particular signal if you know the type of the Custom Signal you expecting to recieve, you can actually use concrete class name in signature to avoid unnecessary castings and access properties of Custom Signal directly;
         */
		public var signal		:ISignal 	= attachSignal();
		
		/**
		 * Constructor, Actor is an abstract class, cannot be directly instatiated. 
		 */
		public function Actor()
		{
			if(Object(this).constructor == Actor) throw new IllegalOperationError("Abstract Class");
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
		 * Will detach all registered signals form a system and clear all nesesary references.
		 * Subclasses should override this method and call super.destroy();.
		 * On Subclass level you don't have to care about signal removal, only references of the objects you have created.
		 */
		public function destroy():void
		{
			_observer.removeAllSlotsOf(_uid);
			_observer = null;
			_stage = null;
			
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
			signal.BIXBITE::actor = Object(this).constructor;
			this.signal = signal;
			
			return signal;
		}
		
		/**
		 * Shared method across all actors to register callbacks of specific type of signal and asociate them with Actors.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			_observer.addSlot(_uid, type, callback);
		}
		
		/**
		 * remove slot / unregister this specific actor from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			_observer.removeSlot(_uid, type);
		}
		
		/**
		 * This method will remove entire slot of specific type, no matter witch actor is calling all registered acctors will stop recieveing any signals
		 * @param	type
		 */
		public function removeAllSlots(type:String):void
		{
			_observer.removeAllSlots(type);
		}
		
		/**
		 * Reference to System I/O (Stage)
		 */
		public function get stage():Stage 
		{
			return _stage;
		}
		
		/**
		 * Unique actor identifier
		 */
		public function get uid():String 
		{
			return _uid;
		}
		
		/**
		 * Unique actor identifier controlled by observer
		 * @param	uid
		 */
		BIXBITE function setUID(uid:String):void
		{
			_uid = uid;
		}
		
	}

}