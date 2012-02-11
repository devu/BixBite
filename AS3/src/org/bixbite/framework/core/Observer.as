package org.bixbite.framework.core
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	import org.bixbite.framework.core.Slot;
	import org.bixbite.framework.interfaces.*;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Observer
	{	
		private static var _instance:Observer = new Observer();
		
		private var slots	:Dictionary = new Dictionary();
		private var shortRef:Function;
		
		public function Observer()
		{
			//singleton
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(caller:IActor, type:String, callback:Function, weakKeys:Boolean = false):void
		{
			if (!slots[type]) slots[type] = new Slot(weakKeys);
			Slot(slots[type]).add(caller, callback);
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 */
		public function removeSlot(caller:IActor, type:String):void
		{
			Slot(slots[type]).remove(caller);
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 */
		public function destroySlot(type:String):void
		{
			delete slots[type];
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):Slot
		{
			if (slots[type]) Slot(slots[type]).dispatch(params);
			return slots[type];
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):Function
		{
			return Slot(slots[type]).dispatchTo(target, params);
		}
		
		/**
		 * Getters / Setters
		 */
		static public function get instance():Observer { return _instance; }
	}

}