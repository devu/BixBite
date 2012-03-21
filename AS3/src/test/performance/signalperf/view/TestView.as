package test.performance.signalperf.view 
{
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.View;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestView extends View 
	{
		
		public function TestView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("test", onTest);
		}
		
		private function onTest(s:ISignal):void 
		{
			
		}
		
	}

}