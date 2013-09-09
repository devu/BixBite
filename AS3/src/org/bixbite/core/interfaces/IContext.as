package org.bixbite.core.interfaces 
{
	import org.bixbite.core.View;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public interface IContext 
	{
		function get id():String;
		function set id(value:String):void;
		
		function set parrentView(value:View):void;
		function get parrentView():View 
		
		function dispose():void;
	}
	
}