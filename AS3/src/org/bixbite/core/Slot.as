package org.bixbite.core 
{
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Slot 
	{
		public var uid			:String;
		public var send 		:Function;
		
		internal var index		:int;
		internal var next		:Slot;
		
		public function Slot(uid:String, callback:Function) 
		{
			this.uid = uid;
			this.send = callback;
		}
		
		public function dispose():void
		{
			this.uid = null;
			this.send = null;
		}
	}

}