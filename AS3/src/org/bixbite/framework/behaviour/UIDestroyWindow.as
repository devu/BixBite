package org.bixbite.framework.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 * @author devu
	 */
	public class UIDestroyWindow extends Behaviour 
	{
		override public function init():void 
		{
			trace(this, "init");
		}
		
		override public function execute(s:Signal):void
		{
			trace(this, "execute");
		}
	}

}