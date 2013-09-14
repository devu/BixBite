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
			addSlot(UISignal.DATA_REQUEST, onDataRequest);
		}
		
		private function onDataRequest(s:Signal):void 
		{
			trace(this, "onDataRequest");
			responseToAll(UISignal.ON_DATA);
		}
		
	}

}