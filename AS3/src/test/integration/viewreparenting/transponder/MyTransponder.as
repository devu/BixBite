package test.integration.viewreparenting.transponder 
{
	import flash.events.MouseEvent;
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MyTransponder extends Transponder 
	{
		
		public function MyTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
			addSensor(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			e.target.startDrag();
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			e.target.stopDrag();
		}
		
		
	}

}