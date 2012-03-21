package test.performance.signalperf 
{
	import org.bixbite.core.Application;
	import org.bixbite.framework.controller.StageController;
	import org.bixbite.framework.modules.stats.Stats;
	import org.bixbite.framework.view.StageView;
	import test.performance.signalperf.controller.TestController;
	import test.performance.signalperf.model.TestModel;
	import test.performance.signalperf.view.TestView;
	
	/**
	 * Subject of this test is to check performance of the current MVC specific signal flow implementation.
	 * It is protected on the core level witch actor can talk to witch one. 
	 * Also checking entire triad communication not just signal broadcasting removed from the context.
	 * 
	 * 1 Phase
	 * On mouse click Controller will send signal to Model and Model respond to View.
	 * This is just test a flow test. Making sure View and Model can get response from Controller in controller manier.
	 * 
	 * 2 Phase
	 * Once 1 Phase is finished View will send X number of times signals going through full triade following the flow:
	 * View -> Controller -> Model -> View. When finish will send signal to Stats to display results.
	 * 
	 * Results (Flash Player 11,1,102,63 - Chrome)
	 * Signals traveling from View -> Controller -> Model -> View.
	 * 1.000 		- 2ms		(3k signals in circulation)
	 * 10.000 		- 22ms		(30k signals in circulation)
	 * 100.000		- 207ms		(300k signals in circulation)
	 * 1.000.000	- 2120ms	(3M signals in circulation)
	 */
	public class SignalPerformance extends Application 
	{
		
		public function SignalPerformance() 
		{
			var stageCtrl:StageController = new StageController();
			var stageView:StageView = new StageView();
			
			var stats:Stats = new Stats(stageView);
			
			var m:TestModel = new TestModel();
			var v:TestView = new TestView();
			var c:TestController = new TestController();
		}
		
	}

}