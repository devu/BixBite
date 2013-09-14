/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.behaviour 
{
	import flash.display.Stage;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.StageData;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	
	
	/**
	 * @langversion	3.0
	 */
	public class ResizeStage extends Behaviour 
	{
		private var stageData	:StageData;
		private var stage		:Stage;
		
		override public function init():void
		{
			addResponder(StageManager.DATA_REQUEST, onData, true);
		}
		
		private function onData(data:StageData):void
		{
			removeResponder(StageManager.DATA_REQUEST);
			
			this.stageData = data;
			stage = stageData.stage;
			
			stageData.orientation = "notSet";
		}
		
		override public function execute(s:Signal):void
		{
			var currentOrientation:String = checkOrientation();
			
			if (stageData.orientation != currentOrientation){
				stageData.orientation = currentOrientation;
				emitSignal(StageSignal.ON_ORIENTATION_CHANGED, stageData);
				sendSignal(StageSignal.ON_ORIENTATION_CHANGED, stageData );
			}
			
			emitSignal(StageSignal.ON_RESIZE, stageData);
			sendSignal(StageSignal.ON_RESIZE, stageData);
		}
		
		private function checkOrientation():String 
		{
			return (stage.stageWidth <= stage.stageHeight) ? StageData.PORTRAIT : StageData.LANDSCAPE;
		}
		
		override public function dispose():void 
		{
			removeResponder(StageManager.DATA_REQUEST);
			
			stageData = null;
			stage = null;
			
			super.dispose();
		}
		
	}

}