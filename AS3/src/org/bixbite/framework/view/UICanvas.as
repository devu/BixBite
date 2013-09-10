package org.bixbite.framework.view 
{
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @author devu
	 */
	public class UICanvas extends View 
	{
		override public function init():void 
		{
			trace(this, "init");
			addSlot(UISignal.INIT, onInit);
		}
		
		private function onInit(s:Signal):void 
		{
			trace("UI canvas initialised");
		}
	}

}