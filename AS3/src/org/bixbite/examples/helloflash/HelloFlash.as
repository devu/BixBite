package org.bixbite.examples.helloflash 
{
	import org.bixbite.core.Application;
	import org.bixbite.examples.helloflash.view.MainView;
	import org.bixbite.framework.view.StageView;
	import org.bixbite.examples.helloflash.controller.BallController;
	import org.bixbite.examples.helloflash.model.HelloFlashModel;
	
	/**
	 * @version  compatibility - 0.4.0
	 * This imlementation is based on Robotlegs HelloFlash example. To show you diferences in how we dealing with stuff.
	 * 
	 * Results:
	 * 
	 * Bixbite
	 * 6 Classes to get job done.
	 * 5.37 kb footprint.
	 * Cleaner code.
	 * MVC bring back to conventional paradigm, no mediators, no commands. 1 level of abstraction only.
	 * Speed? let's not talk about it again ;)
	 * 
	 * RL
	 * 8 Classes to get job done.
	 * 16.7 kb footprint
	 * Taking longer to compile.
	 * MVC misconceptions, mediators perofm GUI logic and states of objects, Controllers doing business logic and controlls state of application instead of Model, no Applicataion model at all. 
	 * There is separate Model for stats witch is pointless.
	 * Speed? let's not talk about it again ;)
	 */
	public class HelloFlash extends Application
	{
		
		public function HelloFlash() 
		{
			var c:BallController 	= new BallController();
			var v:MainView 			= new MainView();
			var m:HelloFlashModel 	= new HelloFlashModel();
			
			// And we're done ;)
		}
	}

}