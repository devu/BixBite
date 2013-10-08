/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core.interfaces 
{
	import org.bixbite.core.Context;
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
	}
	
}