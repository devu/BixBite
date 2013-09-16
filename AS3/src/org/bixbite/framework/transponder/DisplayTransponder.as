/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.transponder 
{
	import flash.events.Event;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.DisplayManager;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplayTransponder extends Transponder 
	{
		
		override public function init():void 
		{
			addSensor(Event.RESIZE, onDisplayResize);
			
			transmit(DisplaySignal.SET_DISPLAY);
			transmit(DisplaySignal.GET_DISPLAY);
		}
		
		private function onDisplayResize(e:Event):void 
		{
			sendSignal(DisplayManager.RESIZE);
		}
		
		override public function destroy():void 
		{
			removeSensor(Event.RESIZE, onDisplayResize);
			removeSlot(DisplaySignal.SET_DISPLAY);
			
			super.destroy();
		}
	}

}