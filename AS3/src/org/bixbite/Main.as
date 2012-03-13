package org.bixbite 
{
	import org.bixbite.classic.controller.StageController;
	import org.bixbite.classic.view.StageView;
	import org.bixbite.core.Application;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Main extends Application 
	{
		
		public function Main() 
		{
			var stageCtrl	:StageController 	= new StageController();
			var stageView	:StageView 			= new StageView();
		}
		
	}

}