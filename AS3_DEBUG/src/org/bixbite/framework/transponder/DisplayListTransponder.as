package org.bixbite.framework.transponder 
{
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class DisplayListTransponder extends Transponder 
	{
		public function DisplayListTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("DisplayListManager.INIT", transmit);
			
			addSlot(DisplaySignal.SET_CONTEXT, transmit);
			addSlot(DisplaySignal.ADD_CONTEXT, transmit);
			//TODO
			//transmit("DisplayListManager.INIT");
		}
		
		private function transmit(s:Signal):void 
		{
			forward(s);
		}
		
	}

}