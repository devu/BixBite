package org.bixbite.examples.helloflash.controller 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import org.bixbite.core.Model;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	
	public class BallController extends Model 
	{
		public function BallController()
		{
			
		}
		
		override public function init():void 
		{
			system.addListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			system.addListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/**
		 * Controll, yes, this is what controller is for, capture user input and perform GUI logic.
		 * There is not too much logic behind in this example anyway. Faind out if any ball has been clicked, then broadcast signal you (contrlloer things is adequte for this situatuion);
		 * "The Controller interprets the mouse and keyboard inputs from the user, commanding the model and/or the view to change as appropriate."
		 * @param	e native event listener.
		 */
		private function onMouseDown(e:MouseEvent):void 
		{
			var balls:Array = system.getObjects();
			for each(var b:DisplayObject in balls){
				if (b.name == "ball") sendSignal(BallSignal.POKE);
				return;
			}
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			
		}
		
	}

}