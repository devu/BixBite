package org.bixbite.framework.interfaces 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public interface IView extends IActor
	{
		function addChild(child:DisplayObject):DisplayObject
		function removeChild(child:DisplayObject):DisplayObject
		
		function get x():Number
		function set x(value:Number):void
		
		function get y():Number
		function set y(value:Number):void
		
		function get width():Number
		function set width(value:Number):void
		
		function get height():Number
		function set height(value:Number):void
	}
	
}