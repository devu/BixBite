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
	public class TestControllerBeta extends Controller 
	{
		private var time:int;
		
		public function TestControllerBeta(stage:Stage) 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			time = getTimer();
			
			//var vo:ValueObject = new ValueObject();
			//get current time
			//vo.time = getTimer();
			
			//and notify our Model
			for (var i:int = 0; i < 100; i++) sendSignal("doSomething");
			
			trace("time", getTimer() - time);
		}
		
	}

}