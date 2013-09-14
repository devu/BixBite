/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.data 
{
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	
	/**
	 * @langversion	3.0
	 */
	public class StageData extends Data
	{
		public static const PORTRAIT	:String = "PORTRAIT";
		public static const LANDSCAPE	:String = "LANDSCAPE";
		
		public var orientation			:String;
		
		override public function init():void 
		{
			addSlot(StageManager.DATA_REQUEST, onDataRequest);
			addSlot(StageSignal.SET_STAGE, onStageSet);
		}
		
		private function onDataRequest(s:Signal):void
		{
			responseTo(s.callerUID, StageManager.DATA_REQUEST);
		}
		
		private function onStageSet(s:Signal):void
		{
			stage.align 		= s.params.align;
			stage.scaleMode 	= s.params.scaleMode;
			stage.frameRate		= s.params.frameRate;
		}
		
		override public function destroy():void 
		{
			removeSlot(StageManager.DATA_REQUEST);
			removeSlot(StageSignal.SET_STAGE);
			
			orientation = null;
			
			super.destroy();
		}
		
		public function get width():Number 
		{
			return stage.stageWidth;
		}
		
		public function get height():Number 
		{
			return stage.stageHeight;
		}
		
	}
}