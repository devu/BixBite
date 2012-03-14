package org.bixbite.examples.stats 
{
	import org.bixbite.classic.controller.StageController;
	import org.bixbite.core.Application;
	import org.bixbite.examples.stats.controller.StatsController;
	import org.bixbite.examples.stats.model.StatsModel;
	import org.bixbite.examples.stats.view.StatsView;
	
	/**
	 * This is example of how famous stats by mrdoob can be implemented within bixbite mvc framework.
	 * It is also fork of my fork :) MobileStats.as.
	 * 
	 * IMPORTANT: This is just an example to show a flow, do not use it for projects.
	 * There will be proper optimised version provided as a functional module as a part of framework.
	 */
	public class MainStats extends Application 
	{
		/**
		 * Constructor, set a triad (StageController is a temporary controller if this project runs as independend Application. 
		 * In fact Stats by nature will run as module always, so they can use already added StageController.
		 */
		public function MainStats() 
		{
			//For presentaion purposes only
			var stageCtrl:StageController = new StageController();
			
			//Set of actors needed to perform this task.
			var m:StatsModel 		= new StatsModel();
			var v:StatsView 		= new StatsView();
			var c:StatsController 	= new StatsController();
			
			// If you will study this example, you can quickly recognise posibilities that Bixbite opens.
			// You can easly replace any of the actor with your own implementation. 
			// More likely create diferent sets of Views that display same set od data diferent way. 
			// Classes are loosly coupled so you will not breake any dependanices at all.
		}
		
	}

}