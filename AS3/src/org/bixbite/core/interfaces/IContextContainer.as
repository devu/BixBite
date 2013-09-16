package org.bixbite.core.interfaces 
{
	import org.bixbite.core.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public interface IContextContainer extends IContext 
	{
		function add(context:Context):Context
		function remove(child:Context):Context 
	}
	
}