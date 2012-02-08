package examples.controller
{
	import examples.signals.ValueObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import org.bixbite.framework.core.Controller;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestController extends Controller 
	{
		
		public function TestController(stage:Stage) 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/*override public function init():void 
		{
			
		}*/
		
		private function onMouseDown(e:MouseEvent):void 
		{
			// let's click on the stage 
			//trace("controller down ->");
			//create some value object to send some info with
			var vo:ValueObject = new ValueObject();
			//get current time
			vo.time = getTimer();
			//and notify our Model
			sendSignal("doSomething", vo);
		}
		
	}

}