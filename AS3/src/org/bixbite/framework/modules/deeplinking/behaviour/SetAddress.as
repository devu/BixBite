package org.bixbite.framework.modules.deeplinking.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class SetAddress extends Behaviour 
	{
		
		public function SetAddress() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
		}
		
		override public function execute(s:ISignal):void 
		{
			trace(this, "execute");
		}
		
	}

}