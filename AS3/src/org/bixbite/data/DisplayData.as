/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.data 
{
	import flash.display.Stage;
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.signal.Display;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplayData extends Data
	{
		public var stage		:Stage;
		public var orientation	:String;
		
		override public function init():void 
		{
			addSlot(Display.DATA_REQUEST, onDataRequest);
			addSlot(Display.SET_DISPLAY, onDisplaySet);
		}
		
		private function onDataRequest(s:Signal):void
		{
			responseTo(s.callerUID, Display.DATA_REQUEST);
		}
		
		private function onDisplaySet(s:Signal):void
		{
			stage 				= s.params.root;
			stage.align 		= s.params.align;
			stage.scaleMode 	= s.params.scaleMode;
			stage.frameRate 	= s.params.frameRate;
			
			responseToAll(Display.DATA_REQUEST);
		}
		
		override public function destroy():void 
		{
			removeSlot(Display.DATA_REQUEST);
			removeSlot(Display.SET_DISPLAY);
			
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