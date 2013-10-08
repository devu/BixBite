package org.bixbite.display 
{
	import org.bixbite.core.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public interface IDisplayList 
	{
		function addChild(child:Context):Context;
		function removeChild(child:Context):Context;
	}
	
}