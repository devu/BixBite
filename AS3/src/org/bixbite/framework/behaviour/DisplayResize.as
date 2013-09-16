/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.behaviour 
{
	import flash.display.Stage;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.DisplayData;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.DisplayManager;
	
	
	/**
	 * @langversion	3.0
	 */
	public class DisplayResize extends Behaviour 
	{
		private var displayData	:DisplayData;
		private var stage		:Stage;
		
		override public function init():void
		{
			addResponder(DisplayManager.DATA_REQUEST, onData, true);
		}
		
		private function onData(data:DisplayData):void
		{
			this.displayData = data;
			stage = displayData.stage;
			
			displayData.orientation = checkOrientation();
		}
		
		override public function execute(s:Signal):void
		{
			var currentOrientation:String = checkOrientation();
			
			if (displayData.orientation != currentOrientation){
				displayData.orientation = currentOrientation;
				emitSignal(DisplaySignal.ON_ORIENTATION_CHANGED, displayData);
				sendSignal(DisplaySignal.ON_ORIENTATION_CHANGED, displayData );
			}
			
			emitSignal(DisplaySignal.ON_RESIZE, displayData);
			sendSignal(DisplaySignal.ON_RESIZE, displayData);
		}
		
		private function checkOrientation():String 
		{
			return (stage.stageWidth <= stage.stageHeight) ? DisplayData.PORTRAIT : DisplayData.LANDSCAPE;
		}
		
		override public function dispose():void 
		{
			removeResponder(DisplayManager.DATA_REQUEST);
			
			displayData = null;
			stage = null;
			
			super.dispose();
		}
		
	}

}