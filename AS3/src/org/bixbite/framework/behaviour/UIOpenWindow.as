package org.bixbite.framework.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.UIData;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @author devu
	 */
	public class UIOpenWindow extends Behaviour 
	{
		override public function init():void 
		{
			trace(this, "init");
			sendRequest(UISignal.INIT, onDataInit);
		}
		
		private function onDataInit(data:UIData):void
		{
			trace("onDataInit");
		}
		
		override public function execute(s:Signal):void 
		{
			trace(this, "execute");
		}
		
	}

}