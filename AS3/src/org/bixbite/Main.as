package org.bixbite 
{
	import org.bixbite.framework.controller.StageController;
	import org.bixbite.framework.view.StageView;
	import org.bixbite.core.Application;
	
	/**
	 * GIT FD plugin test
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