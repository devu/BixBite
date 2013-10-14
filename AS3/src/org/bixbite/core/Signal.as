/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>Signal is a base class for all signals being propagated within a system.
     * Provides all necessary getters in read-only mode, and setters automatically controlled by system.
     * At the same time helping you solve all architectural problems without referencing objects and keep your Components and Compounds completely decoupled, unaware of each other makes a perfect modular system to work with and more importantly easy to maintain.</p>
     *
     * <p>In case you need to send more valuable informations within an signal you can use build in params object.</p>
	 * 
	 * @langversion	3.0
     */
	public class Signal
	{
		private var _callerUID		:String;
		private var _params			:Object;
		
		/**
		 * Constructor
		 * @param	uid
		 */
		public function Signal(uid:String)
		{
			_callerUID = uid;
		}
		
		/**
         * Unique identifier of the caller.
         * This method will provide unique id of the Component that sending particular signal.
         * This will give you opportunity to respond directly to the sender without cross-referencing them.
         */
		public function get callerUID():String
		{
			return _callerUID;
		}
		
		/**
		 * @private
		 * System controlled setter for caller unique id.
		 */
		BIXBITE function set callerUID(value:String):void 
		{
			_callerUID = value;
		}
		
		/**
		 * Params Object holder getter
		 */
		public function get params():Object { return _params; }
		
		/**
		 * Params Object holder setter
		 */
		public function set params(params:Object):void { _params = params; }
		
		/**
		 * @private
		 * system controlled method to automatically deconstruct signal
		 */
		BIXBITE function destroy():void
		{
			_callerUID = null;
			if(_params){
				for (var p:String in _params) trace(_params[p]);
				_params = null;
			}
		}
	}

}