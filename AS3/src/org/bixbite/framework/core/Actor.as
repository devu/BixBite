package org.bixbite.framework.core 
{
	import avmplus.getQualifiedClassName;
	import flash.errors.IllegalOperationError;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IValueObject;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Actor implements IActor
	{
		private var _uid			:int = -1;
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
			_uid = observer.BIXBITE::getUID();
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
		public function addSlot(type:String, callback:Function):void
		{
			observer.BIXBITE::addSlot(uid, type, callback);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			observer.BIXBITE::removeSlot(uid, type);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function destroySlot(type:String):void
		{
			observer.BIXBITE::removeSlot(uid, type);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):Array
		{
			return observer.BIXBITE::sendSignal(type, params);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):Function
		{
			return observer.BIXBITE::sendSignalTo(target.uid, type, params);
		}
		
		/**
		 * Getters / Setters
		 */
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
		
		//read only
		public function get uid():int { return _uid; }
	}

}