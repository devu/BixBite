package test.performance.signalperf.controller 
{
	import flash.events.MouseEvent;
	import org.bixbite.core.Controller;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestController extends Controller 
	{
		
		public function TestController() 
		{
			
		}
		
		override public function init():void 
		{
			system.addListener(MouseEvent.CLICK, runTest);
		}
		
		private function runTest(e:MouseEvent):void 
		{
			sendSignal("test");
		}
		
	}

}