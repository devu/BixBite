package org.bixbite.debug.vo 
{
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AbstractComponent 
	{
		public var name		:String;
		
		public function AbstractComponent(name:String) 
		{
			this.name = name;
		}
		
		public function markAsDuplicate():void
		{
			trace(this, name, "duplicate");
		}
		
	}

}