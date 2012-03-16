package org.bixbite.examples.helloflash 
{
	import org.bixbite.classic.view.StageView;
	import org.bixbite.core.Application;
	import org.bixbite.examples.helloflash.controller.BallController;
	import org.bixbite.examples.helloflash.model.HelloFlashModel;
	import org.bixbite.examples.helloflash.signal.AppSignal;
	import org.bixbite.examples.helloflash.view.Readout;
	
	/**
	 * This imlementation is based on Robotlegs HelloFlash example. To show you diferences in how we dealing with stuff.
	 * In this example we trying to stay as close to original as we can. But we can't accept breaking the rules. So it's a compromise.
	 * We will also provide 'ideal' or recomended implementation of this example as well.
	 */
	public class HelloFlash extends Application 
	{
		
		public function HelloFlash() 
		{
			var m:HelloFlashModel 	= new HelloFlashModel();
			var v:StageView 		= new StageView();
			var c:BallController 	= new BallController(v);
			var readout:Readout 	= new Readout();
			
			v.addView(readout);
			
			m.sendSignal(AppSignal.STARTUP);
			
			// And we're done ;)
		}
		
	}

}