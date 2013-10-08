/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core.interfaces 
{
	/**
	 * @langversion	3.0
	 */
	public interface IActor extends IComponent
	{
		function addSlot(type:String, callback:Function):void;
		
		function removeSlot(type:String):void;
		
		function sendSignal(type:String, params:Object = null):void;
	}
	
}