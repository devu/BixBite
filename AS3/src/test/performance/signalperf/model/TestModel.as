package test.performance.signalperf.model 
{
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestModel extends Model 
	{
		
		public function TestModel() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("test", onTest);
		}
		
		private function onTest(s:ISignal):void 
		{
			sendSignal("test");
		}
		
	}

}