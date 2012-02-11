package com.mindScriptAct.bixbite.controller.signals 
{
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MessageVO implements IValueObject 
	{
		public var msg:String;
		
		public function MessageVO(msg:String) 
		{
			this.msg = msg;
		}
		
	}

}