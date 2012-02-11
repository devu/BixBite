package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	import org.bixbite.framework.core.Application;
	import org.bixbite.framework.interfaces.IValueObject;
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Ross
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
			for (i = 0; i < loops; i++) testSignals();
			out((getTimer() - time) + " - RP Signal");
			
			tare();
			
			time = getTimer();
			for (i = 0; i < loops; i++) testDeluxeSignals();
			out((getTimer() - time) + " - RP Deluxe Signal: ");
			
			tare();
			
			time = getTimer();
			eventDispatcher.addEventListener(eventType, eventHandler);
			for (i = 0; i < loops; i++) testEvents();
			out((getTimer() - time) + " - Event: ");
			
			tare();
			
			bixbite.addSlot(signalType, bixbiteSignalHandler);
			time = getTimer();
			for (i = 0; i < loops; i++) testBixbite();
			out((getTimer() - time) + " - Bixbite: ");
		}
		
		private function tare():void 
		{
			for (var i:uint = 0; i < loops; i++) { }
		}
		
		private function testSignals():void 
		{
			signal.add(signalHandler);
			signal.dispatch();
			signal.removeAll();
		}
		
		private function signalHandler():void {}
		
		private function testDeluxeSignals():void 
		{
			deluxeSignal.dispatch();
		}
		
		private function deluxeSignalHandler():void {}
		
		private function testEvents():void 
		{
			eventDispatcher.dispatchEvent(event);
		}
		
		private function eventHandler(e:Event):void { }
		
		private function testBixbite():void 
		{
			bixbite.sendSignal(signalType);
		}
		
		private function bixbiteSignalHandler(s:IValueObject):void { }
		
		protected function out(str:*):void 
		{
			output.appendText(String(str) + "\n");
			output.scrollV = output.maxScrollV;
		}
	}
}