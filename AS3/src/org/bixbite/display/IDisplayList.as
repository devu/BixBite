package org.bixbite.display 
{
	import org.bixbite.core.interfaces.IContext;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public interface IDisplayList 
	{
		function addChild(child:IContext):IContext;
		function removeChild(child:IContext):IContext;
		
		function debug(ctx:XML):void;
	}
	
}