package test.performance.signalperf 
{
	import org.bixbite.core.Application;
	import test.performance.signalperf.controller.TestController;
	import test.performance.signalperf.model.TestModel;
	import test.performance.signalperf.view.TestView;
	
	/**
	 * ...
	 */
	public class SignalPerformance extends Application 
	{
		
		public function SignalPerformance() 
		{
			var m:TestModel = new TestModel();
			var v:TestView = new TestView();
			var c:TestController = new TestController();
		}
		
	}

}