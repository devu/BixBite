package test.performance.signalperf.controller 
{
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import org.bixbite.core.Controller;
	import test.performance.signalperf.signal.TestSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestController extends Controller 
	{
		private var testSignal:TestSignal;
		
		public function TestController() 
		{
			
		}
		
		override public function init():void 
		{
			testSignal = new TestSignal();
			attachSignal(testSignal);
			
			system.addListener(MouseEvent.CLICK, runTest);
			
			addSlot("fullTriade", onFullTriade);
		}
		
		private function runTest(e:MouseEvent):void 
		{
			testSignal.time = getTimer();
			sendSignal("signalFromCtrl");
		}
		
		private function onFullTriade(s:TestSignal):void 
		{
			sendSignal("fullTriade");
		}
	}

}