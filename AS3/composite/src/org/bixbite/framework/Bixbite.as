package org.bixbite.framework
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	import org.bixbite.framework.core.Signal;
	import org.bixbite.framework.interfaces.*;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Bixbite
	{	
		private static var _instance:Bixbite = new Bixbite();
		
		private var slots	:Dictionary = new Dictionary();
		
		public function Bixbite()
		{
			
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(caller:IActor, type:String, callback:Function):void
		{
			if (!slots[type])
				slots[type] = new Signal();
			Signal(slots[type]).add(caller, callback);
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 */
		public function removeSlot(caller:IActor, type:String):void
		{
			Signal(slots[type]).remove(caller);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):void
		{
			if (slots[type])
				Signal(slots[type]).dispatch(params);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):void
		{
			if (slots[type])
				Signal(slots[type]).dispatchTo(target, params);
		}
		
		/**
		 * Getters / Setters
		 */
		static public function get instance():Bixbite { return _instance; }
	}

}