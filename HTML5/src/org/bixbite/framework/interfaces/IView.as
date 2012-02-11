package org.bixbite.framework.interfaces 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public interface IView extends IActor
	{
		function get content():DisplayObject;
		function set content(value:DisplayObject):void
	}
	
}