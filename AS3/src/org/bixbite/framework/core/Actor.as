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
		
		private var sIn			:Function;
		private var sExe		:Function;
		private var sOut		:Function;
		private var sNote		:Function;
		
		/**
		 * 
		 */
		public function Actor() 
		{
			if (Object(this).constructor == Actor)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
				
			bixbite = Bixbite.instance;
			
			this.sOut 	= bixbite.sendSignal;
			this.sExe 	= bixbite.sendSignalTo;
			this.sIn 	= bixbite.addSignal;
			
			init();
		}
		
		/**
		 * 
		 */
		public function init():void 
		{
			//abstract
		}
		
		/**
		 * 
		 * @param	type
		 * @param	callback
		 */
		public function addSignal(type:String, callback:Function):void
		{
			sIn(this, type, callback);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):void
		{
			sOut(type, params);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):void
		{
			sExe(target, type, params);
		}
		
		/**
		 * Getters / Setters
		 */
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
	}

}