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
	import org.bixbite.core.interfaces.IActor;
	import org.bixbite.core.interfaces.IApplication;
	import org.bixbite.core.interfaces.IController;
	import org.bixbite.core.interfaces.IModel;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.interfaces.IView;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The Emiter, singleton, core of the Signal/Slot notification system of this framework.</p>
	 * <p>Provides set of methods for Actors and keeps it dead simple, fast and straight forward. First as well as second dimension relies on native AS3 Object only. Speed of accessibility, creation and deletion was the main important factor behind design decisions. 
	 * If you want to get closer to the native speed of execution, Emiter provides methods to cross-reference callbacks base on type of the signal.</p>
	 * <p>This implementation of notification system is the fastest, the simplest and lightest to compare to any other solution known in AS3. 
	 * This is the only solution that will give you robust structure, perfectly decoupled members of MVC triad and opportunity to execute it with the same seeped as a native local method speed accession. 
	 * You can't go faster than that. So you don't have to sacrifice anything from performance point of view, and you have very powerful modular system that doesn't require any changes if new component/class will be added/moved/removed from it.</p>
	 * <p>Signal/Slot system has been inspired by QT framework, and we took only essence of it.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.4.3
	 */
	public class Emiter
	{
		static private var _instance	:Emiter;
		static private var isRunning	:Boolean;
		
		private var _uid				:int = -1;
		private var _system				:SystemIO;
		private var _application		:IApplication;
		
		private var _slots				:Object = { m: { }, v: { }, c: { } };
		
		use namespace BIXBITE
		
		/**
		 * The Emiter is a singleton, by default and only once via constructor will pass references to the main application.
		 * @param	application
		 */
		public function Emiter(application:IApplication) 
		{
			if (_instance) throw IllegalOperationError("Singleton");
			
			_application 	= application;
			_system 		= new SystemIO(application.stage);
		}
		
		/**
		 * @private
         * Internal method to add slot for any Actor.
         * This is equivalent of addListener or registerNotification known from different systems and implementations.
         * Can be invoked by any Actor.
         * @param    callerUID, unique id of the caller
         * @param    type, type of signal
         * @param    callback, listener of the caller that will be added to the slot of certain type.
         */
		BIXBITE function addSlot(channel:Object, callerUID:String, type:String, callback:Function):void
		{
			if (!channel[type]) channel[type] = { };
			channel[type][callerUID] = callback;
		}
		
		/**
		 * @private
		 * Internal method to remove specific callback assigned to an Actor.
		 * Can be invoked by any Actor.
		 * @param	callerUID, unique id of the caller
		 * @param	type, type of signal
		 */
		BIXBITE function removeSlot(channel:Object, callerUID:String, type:String):void
		{
			if (!channel[type]) return;
			delete channel[type][callerUID];
		}
		
		/**
		 * @private
		 * Remove all registered callbacks within a certain type of signal. 
		 * Can be invoked by any Actor.
		 * @param	type, type of signal
		 */
		BIXBITE function removeAllSlots(channel:Object, type:String):void
		{
			if (!channel[type]) return;
			for (var uid:String in channel[type]) removeSlot(channel, uid, type);
			delete channel[type];
		}
		
		/**
		 * @private
		 * Remove all registered signals of concrete Actor by his unique id.
		 * @param	uid, unique id of the caller
		 */
		BIXBITE function removeAllSlotsOf(channel:Object, uid:String):void
		{
			for (var p:String in channel) {
				removeSlot(channel, uid, p);
				if (isEmpty(channel[p])) delete channel[p];
			}
		}
		
		/**
		 * sendSignal emiter
		 * 
		 * @param	slots
		 * @param	type
		 * @param	signal
		 */
		BIXBITE function broadcast(channel:Object, type:String, signal:ISignal):void 
		{
			if (!channel[type]) return;
			for each (var f:Function in channel[type]) f(signal);
		}
		
		/**
		 * @private
		 * 
		 * @param	slots
		 * @param	type
		 * @param	signal
		 * @param	callback
		 */
		BIXBITE function request(channel:Object, type:String, signal:ISignal, callback:Function):void 
		{
			if (!channel[type]) return;
			for each (var f:Function in channel[type]) callback(f(signal));
		}
		
		/**
		 * @private
         * Each Application will invoke this method in order to register itself within Emiter.
         * Only first one will become root application, any next one will run as a module and get reference to same instance of Emiter.
         * @param    referrer
         * @return   reference to Emiter
         */
		static public function register(referrer:IApplication):Emiter 
		{
			if(!isRunning){
				_instance 	= new Emiter(referrer);
				isRunning 	= true;
			} else {
				referrer.BIXBITE::module = true;
			}
			
			return _instance;
		}
		
		/**
		 * Reference to a Singleton instance of Emiter class.
		 * @return
		 */
		static public function getInstance():Emiter 
		{
			return _instance;
		}
		
		/**
		 * Helper method to quick determination wheter object is empty or not.
		 * As soon as at least one property will be detected will return Boolean otherwise repor about empty object.
		 * @param	object to check
		 * @return 	boolean
		 */
		private function isEmpty(object:Object):Boolean 
		{
			for (var p:String in object) return false;
			return true;
		}
		
		/**
		 * System I/O accessor. In AS3 implementation is a native stage
		 */
		public function get system():SystemIO 
		{
			return _system;
		}
		
		/**
		 * Privides getter to unique id for all Actors.
		 * Each Actor will invoke this method on construction time and Observer's uid act as a fast system iterator.
		 */
		public function get uid():int 
		{
			return ++_uid;
		}
		
		public function get slots():Object 
		{
			return _slots;
		}
		
	}

}