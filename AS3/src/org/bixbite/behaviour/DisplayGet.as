/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.data.DisplayData;
	import org.bixbite.signal.Display;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class DisplayGet extends Behaviour 
	{
		private var requestor:String;
		
		override public function init():void
		{
			addResponder(Display.DATA_REQUEST, onData);
		}
		
		override public function execute(s:Signal):void
		{
			requestor = s.callerUID;
			sendRequest(Display.DATA_REQUEST);
		}
		
		private function onData(data:DisplayData):void
		{
			sendSignalTo(requestor, Display.SET_DISPLAY, data);
		}
		
		override public function destroy():void 
		{
			requestor = null;
			super.destroy();
		}
		
	}
	
}