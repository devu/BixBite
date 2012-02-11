package org.bixbite.framework.core 
{
	import flash.errors.IllegalOperationError;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Actor implements IActor
	{
		private var observer		:Observer;
		private var _name			:String;
		
		/**
		 * 
		 */
		public function Actor() 
		{
			if (Object(this).constructor == Actor)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
				
			observer = Observer.instance;
			
			init();
		}
		
		/**
		 * abstract
		 */
		public function init():void { }
		
		/**
		 * 
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function, weakKeys:Boolean = false):void
		{
			observer.addSlot(this, type, callback, weakKeys);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			observer.removeSlot(this, type);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function destroySlot(type:String):void
		{
			observer.removeSlot(this, type);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):Slot
		{
			return observer.sendSignal(type, params);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):Function
		{
			return observer.sendSignalTo(target, type, params);
		}
		
		/**
		 * Getters / Setters
		 */
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
	}

}