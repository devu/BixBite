/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.data 
{
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.DisplayManager;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplayData extends Data
	{
		public static const PORTRAIT	:String = "PORTRAIT";
		public static const LANDSCAPE	:String = "LANDSCAPE";
		
		public var orientation			:String;
		
		override public function init():void 
		{
			addSlot(DisplayManager.DATA_REQUEST, onDataRequest);
			addSlot(DisplaySignal.SET_DISPLAY, onDisplaySet);
		}
		
		private function onDataRequest(s:Signal):void
		{
			responseTo(s.callerUID, DisplayManager.DATA_REQUEST);
		}
		
		private function onDisplaySet(s:Signal):void
		{
			stage.align 		= s.params.align;
			stage.scaleMode 	= s.params.scaleMode;
			stage.frameRate		= s.params.frameRate;
		}
		
		override public function destroy():void 
		{
			removeSlot(DisplayManager.DATA_REQUEST);
			removeSlot(DisplaySignal.SET_DISPLAY);
			
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