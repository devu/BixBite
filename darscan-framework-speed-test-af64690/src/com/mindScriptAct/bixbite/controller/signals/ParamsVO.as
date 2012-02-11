package com.mindScriptAct.bixbite.controller.signals 
{
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ParamsVO implements IValueObject 
	{
		public var data:String;
		
		public function ParamsVO(data:String) 
		{
			this.data = data;
		}
		
	}

}