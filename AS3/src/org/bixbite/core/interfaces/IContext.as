/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core.interfaces 
{
	import org.bixbite.core.View;
	
	/**
	 * @langversion	3.0
	 */
	public interface IContext 
	{
		function get id():String;
		function set id(value:String):void;
		
		function set view(value:View):void;
		function get view():View
		
		function init():void;
		function draw():void;
		function dispose():void;
		
		function getContextUnderPoint(name:String = null):IContext;
		
		function addSensor(type:String, callback:Function):void;
		function removeSensor(type:String, callback:Function):void;
		
		function addChild(child:IContext):IContext;
		function removeChild(child:IContext):IContext;
		
		function get body():*;
	}
	
}