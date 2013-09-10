package org.bixbite.framework.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @author devu
	 */
	public class UIInitialise extends Behaviour 
	{
		override public function init():void 
		{
			trace(this, "init");
		}
		
		override public function execute(s:Signal):void 
		{
			trace(this, "execute");
			sendRequest(UISignal.INIT);
			sendSignal(UISignal.INIT);
		}
	}

}