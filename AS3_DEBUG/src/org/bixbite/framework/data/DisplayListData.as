package org.bixbite.framework.data 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class DisplayListData extends Data 
	{
		public var list:Dictionary = new Dictionary();
		
		public function DisplayListData() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(DisplaySignal.GET_DISPLAY_LIST, onGetDisplayList);
		}
		
		private function onGetDisplayList(s:Signal):void 
		{
			responseAll(DisplaySignal.GET_DISPLAY_LIST);
		}
		
		public function addContenxt(context:DisplayObject, container:DisplayObjectContainer):void
		{
			
		}
		
	}

}