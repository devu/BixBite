/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.behaviour 
{
	import flash.display.Stage;
	import flash.events.Event;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.data.DisplayData;
	import org.bixbite.signal.Display;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplayResize extends Behaviour 
	{
		private var displayData	:DisplayData;
		private var stage		:Stage;
		
		override public function init():void
		{
			addResponder(Display.DATA_REQUEST, onData);
		}
		
		private function onData(data:DisplayData):void
		{
			this.displayData = data;
			stage = displayData.stage;
			stage.addEventListener(Event.RESIZE, onResize);
			
			displayData.orientation = checkOrientation();
		}
		
		private function onResize(e:Event):void 
		{
			execute(null);
		}
		
		override public function execute(s:Signal):void
		{
			var currentOrientation:String = checkOrientation();
			
			if (displayData.orientation != currentOrientation){
				displayData.orientation = currentOrientation;
				emitSignal(Display.ON_ORIENTATION_CHANGED, displayData);
				sendSignal(Display.ON_ORIENTATION_CHANGED, displayData );
			}
			
			emitSignal(Display.ON_RESIZE, displayData);
			sendSignal(Display.ON_RESIZE, displayData);
		}
		
		private function checkOrientation():String
		{
			return (stage.stageWidth <= stage.stageHeight) ? Display.PORTRAIT : Display.LANDSCAPE;
		}
		
		override public function destroy():void 
		{
			removeResponder(Display.DATA_REQUEST);
			
			displayData = null;
			stage = null;
			
			super.destroy();
		}
		
	}

}