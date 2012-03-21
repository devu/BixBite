package test.performance.signalperf.view 
{
	import flash.utils.getTimer;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.View;
	import org.bixbite.framework.modules.stats.signal.StatsSignal;
	import org.bixbite.framework.modules.stats.signal.TraceSignal;
	import test.performance.signalperf.signal.TestSignal;
	import flash.utils.setInterval;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestView extends View 
	{
		private var testSignal:TestSignal;
		
		public function TestView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("signalFromModel", onSignalFromModel);
			addSlot("signalFromCtrl", onSignalFromController);
			addSlot("signalFromModelFullTriade", onSignalFromModelFullTriade);
		}
		
		/**
		 * Signals from Controller should arrive AFTER signal from Model, if Controller broadcasted exactly same type of signal and both, Model and View listen to it
		 * Phase of this signal should be always 1. Usign phase value you can recognize within View who is calling.
		 * @param	s
		 */
		private function onSignalFromController(s:TestSignal):void
		{
			trace("Signal: Controller->View  Phase:", s.phase);
		}
		
		/**
		 * Signals from Model should always arrive BEFORE signal from Controller, if Controller broadcasted exactly same type of signal and both, Model and View listen to it.
		 * The reason being is to have opportunity to manage the flow and Model can decide about cancelation of the 2nd phase.
		 * @param	s
		 */
		private function onSignalFromModel(s:TestSignal):void 
		{
			var MAX:int = 1000;
			var i:int;
			
			trace("Signal: Controller->Model->View  Phase:", s.phase);
			
			testSignal = s;
			attachSignal(testSignal);
			testSignal.total = getTimer();
			
			for (i = 0 ; i < MAX; i++){
				fullTriadeTest();
			}
			
			var result:String = "View->Controller->Model->View x"+MAX+" " + (getTimer() - testSignal.total) + "ms";
			attachSignal(new TraceSignal("STANDARD", result, 0));
			sendSignal(StatsSignal.TRACE);
		}
		
		private function onSignalFromModelFullTriade(s:TestSignal):void
		{
			//end point of full triade test
		}
		
		private function fullTriadeTest():void
		{
			sendSignal("fullTriade");
		}
		
	}

}