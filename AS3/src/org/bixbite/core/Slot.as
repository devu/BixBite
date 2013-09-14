/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	/**
	 * The Slot is a value object to hold references of the callback and unique id associated with a Component
	 * @langversion	3.0
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