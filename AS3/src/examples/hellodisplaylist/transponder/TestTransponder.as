package examples.hellodisplaylist.transponder 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestTransponder extends Transponder 
	{
		
		public function TestTransponder()
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onInputDown);
		}
		
		private function onInputDown(e:MouseEvent):void 
		{
			var name:String = getDisplayObjectName(e.target);
			trace(name);
			
			switch(name)
			{
				case "subView":
					sendSignal(DisplaySignal.REMOVE_CONTEXT, { name:name } );
					break;
			}
		}
	}

}