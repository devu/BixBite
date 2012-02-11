package org.examples.controller
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import org.bixbite.framework.core.Controller;
	import org.examples.signals.ValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestController extends Controller 
	{
		private var time:int;
		
		public function TestController(stage:Stage) 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			//create some value object to send some info with
			
			//get current time
			time = getTimer();
			
			//doesn't have big impact for performance
			//var vo:ValueObject = new ValueObject();
			//vo.time = time
			
			//and notify our Model
			sendSignal("doSomething");
			
			trace("time", getTimer() - time);
		}
		
	}

}