package org.bixbite.framework.modules.activeGrid.data 
{
	import org.bixbite.core.Data;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.signals.ActiveGridSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ActiveGridData extends Data 
	{
		public var landscapeRanges	:Array 	= [480, 640, 800, 960, 1024, 1280, 1920];
		public var portraitRanges	:Array 	= [320, 480, 640, 800, 1080];
		public var moduleSize		:int 	= 40;
		
		public var boxes			:Array = [];
		
		public function ActiveGridData() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(ActiveGridSignal.DATA_REQUEST, onDataRequest);
		}
		
		private function onDataRequest(s:ISignal):void 
		{
			responseTo(s.callerUID, ActiveGridSignal.DATA_REQUEST);
		}
		
		public function addBox(w:int, h:int, color:uint):void
		{
			boxes.push(new Box(w, h, color));
		}
		
	}

}

internal class Box
{
	public var x		:int = 0;
	public var y		:int = 0;
	public var w		:int;
	public var h		:int;
	public var d		:int = 0;
	public var color	:uint;
	
	public function Box(w:int, h:int, color:uint)
	{
		this.w = w;
		this.h = h;
		this.d = w * h;
		this.color = color;
	}
}