package org.bixbite.examples.helloflash 
{
	import org.bixbite.classic.view.StageView;
	import org.bixbite.core.Application;
	import org.bixbite.examples.helloflash.controller.BallController;
	import org.bixbite.examples.helloflash.model.HelloFlashModel;
	import org.bixbite.examples.helloflash.view.Readout;
	
	/**
	 * This imlementation is based on Robotlegs HelloFlash example. To show you diferences in how we dealing with stuff.
	 * In this example we trying to stay as close to original as we can. But we can't accept breaking the rules. So it's a compromise.
	 * We will also provide 'ideal' or recomended implementation of this example as well.
	 * 
	 * Results:
	 * 
	 * Bixbite
	 * 6 Classes to get job done.
	 * 5.15 kb footprint.
	 * Cleaner code.
	 * MVC bring back to normal, no mediators, no commands. 1 level of abstraction only.
	 * Speed? let's not talk about it again ;)
	 * 
	 * RL
	 * 8 Classes to get job done.
	 * 16.7 kb footprint
	 * Taking longer to compile.
	 * MVC misconceptions, mediators perofm GUI logic, Controllers doing business logic instead of Model, no Applicataion model at all. 
	 * That also puched authors to create separate Model for stats witch is pointless.
	 * Speed? let's not talk about it again ;)
	 */
	public class HelloFlash extends Application 
	{
		
		public function HelloFlash() 
		{
			var v:StageView 		= new StageView();
			var c:BallController 	= new BallController(v);
			var m:HelloFlashModel 	= new HelloFlashModel();
			var readout:Readout 	= new Readout();
			v.addView(readout);
			
			// And we're done ;)
		}
		
	}

}