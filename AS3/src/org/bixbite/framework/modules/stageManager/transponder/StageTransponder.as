package org.bixbite.framework.modules.stageManager.transponder 
{
	import flash.events.Event;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signals.StageSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class StageTransponder extends Transponder 
	{
		
		public function StageTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSensor(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void 
		{
			sendSignal(StageSignal.RESIZE);
		}
		
	}

}