package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	import org.bixbite.framework.core.Application;
	import org.bixbite.framework.core.Slot;
	import org.bixbite.framework.interfaces.IValueObject;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Ross, modified by Daniel Wasilewski
	 */
	public class Main extends Sprite 
	{
		private var output:TextField;
		
		private var signal:Signal = new Signal();
		private var deluxeSignal:DeluxeSignal = new DeluxeSignal(this);
		
		private var eventType:String = "testEvent";
		private var eventDispatcher:EventDispatcher = new EventDispatcher();
		private var event:Event = new Event(eventType);
		
		private var bixbite:Application = new Application();
		private var signalType:String = "testSignal";
		private var time:int;
		
		public var loops:uint = 100000;
		
		public function Main():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initTest();
		}
		
		private function initTest():void
		{
			output = this.addChild(new TextField()) as TextField;
			output.autoSize = TextFieldAutoSize.LEFT;
			output.text = "Running tests on " + Capabilities.version + " " + (Capabilities.isDebugger ? "DEBUG" : "RELEASE") + "...\n";
			
			tare();
			var i:int;
			
			out("");
			out("Many-2-One");
			
			time = getTimer();
			deluxeSignal.add(deluxeSignalHandler);
			for (i = 0; i < loops; i++) signal.dispatch();
			out((getTimer() - time) + " - RP Signal");
			
			tare();
			
			time = getTimer();
			for (i = 0; i < loops; i++) deluxeSignal.dispatch();
			out((getTimer() - time) + " - RP Deluxe Signal: ");
			
			tare();
			
			time = getTimer();
			eventDispatcher.addEventListener(eventType, eventHandler);
			for (i = 0; i < loops; i++) eventDispatcher.dispatchEvent(event);
			out((getTimer() - time) + " - Event: ");
			
			tare();
			
			bixbite.addSlot(signalType, bixbiteSignalHandler);
			time = getTimer();
			for (i = 0; i < loops; i++) bixbite.sendSignal(signalType);
			out((getTimer() - time) + " - Bixbite send: ");
			
			tare();
			
			time = getTimer();
			for (i = 0; i < loops; i++) bixbite.sendSignalTo(bixbite, signalType); 
			out((getTimer() - time) + " - Bixbite sendTo: ");
			
			tare();
			
			var ref:Slot = bixbite.sendSignal(signalType);
			time = getTimer();
			for (i = 0; i < loops; i++) ref.dispatch();
			out((getTimer() - time) + " - Bixbite send Ref: ");
			
			tare();
			
			var f:Function = bixbite.sendSignalTo(bixbite, signalType); 
			time = getTimer();
			for (i = 0; i < loops; i++) f();
			out((getTimer() - time) + " - Bixbite sendTo Ref: ");
			
			tare()
			
			time = getTimer();
			for (i = 0; i < loops; i++) callbackHandler();
			out((getTimer() - time) + " - Callback: ");
		}
		
		private function tare():void 
		{
			for (var i:uint = 0; i < loops; i++) { }
		}
		
		private function signalHandler():void {}
		private function deluxeSignalHandler():void {}
		private function eventHandler(e:Event):void { }
		private function bixbiteSignalHandler(s:IValueObject = null):void { }
		private function callbackHandler():void {}
		
		protected function out(str:*):void 
		{
			output.appendText(String(str) + "\n");
			output.scrollV = output.maxScrollV;
		}
	}
}