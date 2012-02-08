package org.bixbite.framework.interfaces 
{
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public interface IActor 
	{
		function attachSignal(type:String, callback:Function):void;
		function sendSignal(type:String, params:IValueObject = null):void;
		function sendSignalTo(target:IActor, type:String, params:IValueObject = null):void;
		
		function get name():String
		function set name(value:String):void
	}
	
}