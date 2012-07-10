package test.integration.viewreparenting.transponder 
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.view.ViewSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ViewTransponder extends Transponder 
	{
		
		public function ViewTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
			addSensor(MouseEvent.MOUSE_UP, onMouseUp);
			
			addSlot(ViewSignal.ADDED, onViewAdded);
			addSlot(ViewSignal.REMOVED, onViewRemoved);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{ 
			if (e.target is Stage) return;
			e.target.startDrag();
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if (e.target is Stage) return;
			e.target.stopDrag();
		}
		
		private function onViewAdded(s:ISignal):void 
		{
			response(ViewSignal.ADDED);
		}
		
		private function onViewRemoved(s:ISignal):void 
		{
			response(ViewSignal.REMOVED);
		}
		
	}

}