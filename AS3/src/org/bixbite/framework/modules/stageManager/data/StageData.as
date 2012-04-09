package org.bixbite.framework.modules.stageManager.data 
{
	import flash.display.Stage;
	import org.bixbite.core.Data;
	import org.bixbite.framework.signals.StageSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class StageData extends Data 
	{
		private var stage:Stage;
		
		public function StageData(stage:Stage) 
		{
			this.stage = stage;
		}
		
		override public function init():void 
		{
			addSlot(StageSignal.DATA_REQUEST, onDataRequest);
		}
		
		private function onDataRequest():StageData 
		{
			return this
		}
		
	}

}