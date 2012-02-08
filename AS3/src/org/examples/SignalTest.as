package org.examples 
{
	import flash.sampler.getSize;
	import flash.utils.getTimer;
	import org.bixbite.framework.Application;
	import org.examples.controller.TestController;
	import org.examples.model.TestModel;
	import org.examples.signals.ValueObject;
	import org.examples.view.TestView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class SignalTest extends Application 
	{
		
		public function SignalTest():void
		{
			// Optional
			// super(new GraphicsFactor(), new AssetLoader());
		}
		
		override public function init():void 
		{
			attachSignal("showResults", onShowResults);
		}
		
		private function onShowResults(s:ValueObject):void
		{
			trace("-> TopView -> done in", getTimer() - s.time );
		}
		
		override public function create():void 
		{
			var start:int = getTimer();
			
			new TestModel();
			new TestController(stage);
			
			for (var i:int = 0; i < 1000; i++)
				addChild(new TestView());
			
			trace("MEM USAGE", getSize(this));
			trace("STARTUP", getTimer() - start );
			
		}
		
	}
	
}