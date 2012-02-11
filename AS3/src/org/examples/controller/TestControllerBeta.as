package org.examples.controller
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import org.bixbite.framework.core.Slot;
	import org.bixbite.framework.interfaces.IView;
	import org.examples.view.TestView;
	
	import org.bixbite.framework.core.Controller;
	import org.examples.signals.ValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestControllerBeta extends Controller 
	{
		private var time:int;
		private var stage:Stage;
		private var parentView:TestView;
		private var max:int;
		
		public function TestControllerBeta(stage:Stage, parentView:TestView) 
		{
			this.stage = stage;
			this.parentView = parentView;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var i:int;
			max = 10000;
			
			tare();
			
			time = getTimer();
			
			//var vo:ValueObject = new ValueObject();
			//get current time
			//vo.time = getTimer();
			
			//and notify our Model
			var s:Slot = sendSignal("doSomethingDirect");
			for (i = 0; i < max; i++) s.dispatch();
			//for (i = 0; i < max; i++) sendSignal("doSomethingDirect");
			trace("send", getTimer() - time);
			
			tare();
			
			time = getTimer();
			for (i = 0; i < max; i++) stage.dispatchEvent(new Event("doSomethingDirect"));
			trace("events", getTimer() - time);
			
			tare();
			
			time = getTimer();
			//var f:Function = sendSignalTo(parentView, "doSomething");
			//trace(f);
			var myF:Function = sendSignalTo(parentView, "doSomethingDirect");
			for (i = 0; i < max; i++) myF();
			//for (i = 0; i < max; i++) sendSignalTo(parentView, "doSomethingDirect");
			trace("sendTo", getTimer() - time);
			
			tare();
			
			time = getTimer();
			for (i = 0; i < max; i++) parentView.callMe();
			trace("callback", getTimer() - time);
		}
		
		private function tare():void 
		{
			for (var i:int = 0; i < max; i++){}
		}
		
	}

}