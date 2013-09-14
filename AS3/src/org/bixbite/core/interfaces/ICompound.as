/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core.interfaces 
{
	/**
	 * @langversion	3.0
	 */
	public interface ICompound extends IComponent
	{
		/**
		 * Register any component within current compound
		 * @param	component
		 */
		function register(component:Class, singleton:Boolean = true):IComponent
		
		/**
		 * Unregister any component from current compound
		 * @param	component
		 */
		function unregister(component:Class):void;
	}
	
}