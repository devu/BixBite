package org.bixbite.framework.core 
{
	import flash.errors.IllegalOperationError;
	import org.bixbite.framework.Bixbite;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Actor implements IActor
	{
		private var bixbite		:Bixbite;
		private var _name		:String;
		
		/**
		 * 
		 */
		public function Actor() 
		{
			if (Object(this).constructor == Actor)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
				
			bixbite = Bixbite.instance;
			
			init();
		}
		
		/**
		 * //abstract
		 */
		public function init():void 
		{
			
		}
		
		/**
		 * 
		 * @param	type
		 * @param	callback
		 */
		public function attachSignal(type:String, callback:Function):void
		{
			bixbite.attachSignal(this, type, callback);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function detachSignal(type:String):void
		{
			bixbite.detachSignal(this, type);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):void
		{
			bixbite.sendSignal(type, params);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):void
		{
			bixbite.sendSignalTo(target, type, params);
		}
		
		/**
		 * Getters / Setters
		 */
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
	}

}