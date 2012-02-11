package com.mindScriptAct.bixbite.controller.signals 
{
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class UniqueVO implements IValueObject 
	{
		public var id:int;
		
		public function UniqueVO(id:int) 
		{
			this.id = id;
		}
		
	}

}