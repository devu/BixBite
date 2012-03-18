package org.bixbite 
{
	import org.bixbite.framework.controller.StageController;
	import org.bixbite.framework.view.StageView;
	import org.bixbite.core.Application;
	
	/**
	 * 
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