package org.bixbite.framework.modules.stageManager.behaviour 
{
	import flash.utils.IDataInput;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.modules.stageManager.data.StageData;
	import org.bixbite.framework.signals.StageSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class StageResize extends Behaviour 
	{
		private var stageData:StageData;
		
		public function StageResize() 
		{
			
		}
		
		override public function init():void 
		{
			sendRequest(StageSignal.DATA_REQUEST, onStageData);
		}
		
		private function onStageData(data:StageData):void 
		{
			stageData = data;
		}
		
		override public function execute(s:ISignal):void 
		{
			sendSignal(StageSignal.RESIZE);
		}
		
	}

}