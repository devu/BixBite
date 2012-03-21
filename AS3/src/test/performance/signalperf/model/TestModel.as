package test.performance.signalperf.model 
{
	import flash.utils.getTimer;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	import test.performance.signalperf.signal.TestSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestModel extends Model 
	{
		private var testSignal:TestSignal;
		
		public function TestModel() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("signalFromCtrl", onSignalFromCtrl);
			addSlot("fullTriade", onFullTriade);
		}
		
		private function onSignalFromCtrl(s:TestSignal):void
		{
			trace("Signal: Controller->Model", s.time - getTimer());
			
			testSignal = s;
			attachSignal(testSignal);
			
			sendSignal("signalFromModel");
		}
		
		private function onFullTriade(s:TestSignal):void
		{
			attachSignal(testSignal);
			sendSignal("signalFromModelFullTriade");
		}
		
	}

}