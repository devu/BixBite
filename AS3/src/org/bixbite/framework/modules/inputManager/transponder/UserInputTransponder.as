package org.bixbite.framework.modules.inputManager.transponder 
{
	import flash.events.MouseEvent;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class UserInputTransponder extends Transponder 
	{
		
		public function UserInputTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN	, onInputDown);
			addSensor(MouseEvent.MOUSE_UP	, onInputUp);
		}
		
		private function onInputDown(e:MouseEvent):void 
		{
			trace(this, MouseEvent.MOUSE_DOWN);
			trace(getAllObjects());
		}
		
		private function onInputUp(e:MouseEvent):void 
		{
			trace(this, MouseEvent.MOUSE_UP);
		}
	}

}