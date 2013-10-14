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
		
		function set parent(value:IContext):void;
		function get parent():IContext;
		
		function init():void;
		function draw():void;
		function destroy():void;
		
		function getContextUnderPoint(name:String = null):IContext;
		
		function addSensor(type:String, callback:Function):void;
		function removeSensor(type:String, callback:Function):void;
		
		function addChild(child:IContext):IContext;
		function addChildAt(child:IContext, index:int):IContext;
		function removeChild(child:IContext):void;
		function removeChildAt(index:int):void;
		function removeChildren():void;
		function destroyChildren():void;
		
		function get body():*;
	}
	
}