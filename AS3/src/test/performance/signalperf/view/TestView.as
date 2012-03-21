package test.performance.signalperf.view 
{
	import flash.utils.getTimer;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.View;
	import test.performance.signalperf.signal.TestSignal;
	import flash.utils.setInterval;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestView extends View 
	{
		private var testSignal:TestSignal;
		private var iterator:int;
		
		public function TestView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("signalFromModel", onSignalFromModel);
			addSlot("signalFromModelFullTriade", onSignalFromModelFullTriade);
		}
		
		private function onSignalFromModelFullTriade(s:TestSignal):void
		{
			if (iterator < 295) {
				fullTriadeTest();
			} else {
				trace("View->Controller->Model->View x294", getTimer() - s.total, "ms");
			}
		}
		
		private function onSignalFromModel(s:TestSignal):void 
		{
			trace("Signal: Controller->Model->View", s.time - getTimer());
			
			testSignal = s;
			attachSignal(testSignal);
			
			testSignal.total = getTimer();
			fullTriadeTest();
		}
		
		private function fullTriadeTest():void 
		{
			iterator++;
			sendSignal("fullTriade");
		}
		
	}

}