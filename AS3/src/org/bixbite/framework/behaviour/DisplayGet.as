/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.behaviour 
{
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.DisplayData;
	import org.bixbite.framework.DisplayManager;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class DisplayGet extends Behaviour 
	{
		private var requestor:String;
		
		override public function init():void
		{
			addResponder(DisplayManager.DATA_REQUEST, onData);
		}
		
		override public function execute(s:Signal):void
		{
			requestor = s.callerUID;
			sendRequest(DisplayManager.DATA_REQUEST);
		}
		
		private function onData(data:DisplayData):void
		{
			sendSignalTo(requestor, DisplaySignal.SET_DISPLAY, data);
		}
		
		override public function dispose():void 
		{
			requestor = null;
			super.dispose();
		}
		
	}
	
}