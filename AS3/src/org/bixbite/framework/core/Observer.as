package org.bixbite.framework.core
{
	import org.bixbite.framework.interfaces.*;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Observer
	{	
		private static var _instance:Observer = new Observer();
		
		private var slots		:Array = [];
		private var alocator	:int = -1;
		
		public function Observer()
		{
			//singleton
		}
		
		BIXBITE function getUID():int
		{
			return alocator++
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 * @param	callback
		 */
		BIXBITE function addSlot(callerUID:int, type:String, callback:Function, weakKeys:Boolean = false):void
		{
			if (!slots[type]) slots[type] = [];
			slots[type][callerUID] = callback;
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 */
		BIXBITE function removeSlot(callerUID:int, type:String):void
		{
			//TODO
			//Slot(slots[type]).remove(caller);
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 */
		BIXBITE function destroySlot(type:String):void
		{
			delete slots[type];
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		BIXBITE function sendSignal(type:String, params:IValueObject = null):Array
		{
			if (!slots[type]) return null
			for each (var f:Function in slots[type]) f(params);
			
			return slots[type];
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		BIXBITE function sendSignalTo(callerUID:int, type:String, params:IValueObject = null):Function
		{
			return slots[type][callerUID].call(params)
		}
		
		/**
		 * Getters / Setters
		 */
		static public function get instance():Observer { return _instance; }
	}

}