package org.bixbite.framework.data 
{
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @author devu
	 */
	public class UIData extends Data 
	{
		
		public function UIData() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			addSlot(UISignal.INIT, onInit);
		}
		
		private function onInit(s:Signal):void 
		{
			responseToAll(UISignal.INIT);
		}
		
	}

}