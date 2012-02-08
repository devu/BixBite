package examples 
{
	import examples.controller.TestController;
	import examples.model.TestModel;
	import examples.signals.ValueObject;
	import examples.view.TestView;
	import flash.sampler.getSize;
	import flash.utils.getTimer;
	import org.bixbite.framework.Application;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class SignalTest extends Application 
	{
		
		public function SignalTest():void
		{
			
		}
		
		override public function init():void 
		{
			addSignal("showResults", onShowResults);
			
			trace("MEM USAGE", getSize(this)); //492
		}
		
		private function onShowResults(s:ValueObject):void
		{
			trace("-> TopView -> done in", getTimer() - s.time ); //for 1k views usually 1ms (100k - 34ms)
		}
		
		override public function create():void 
		{
			// set up our test triade
			// don't be afraid, this is not 'PureMVC'. You don't have to register anything, just create to activate, KISS!
			var start:int = getTimer();
			
			new TestModel();
			new TestController(stage);
			
			for (var i:int = 0; i < 1000; i++)
				addChild(new TestView());
			
			trace("MEM USAGE", getSize(this)); //492 yeap, we creating and reusing DRY!
			trace("done in", getTimer() - start ); // for 1k views lag is only 22ms (100k 2504ms)
			
		}
		
	}
	
}