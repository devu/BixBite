/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.transponder 
{
	import flash.events.Event;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	
	/**
	 * @langversion	3.0
	 */
	public class StageTransponder extends Transponder 
	{
		
		override public function init():void 
		{
			addSensor(Event.RESIZE, onStageResize);
			
			transmit(StageSignal.SET_STAGE);
		}
		
		private function onStageResize(e:Event):void 
		{
			sendSignal(StageManager.RESIZE);
		}
		
		override public function destroy():void 
		{
			removeSensor(Event.RESIZE, onStageResize);
			removeSlot(StageSignal.SET_STAGE);
			
			super.destroy();
		}
	}

}