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
		function get content():DisplayObjectContainer;
		function set content(value:DisplayObjectContainer):void
	}
	
}