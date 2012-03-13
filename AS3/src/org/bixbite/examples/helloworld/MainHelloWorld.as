package org.bixbite.examples.helloworld
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.bixbite.core.Application;
	import org.bixbite.examples.helloworld.controller.HelloController;
	import org.bixbite.examples.helloworld.model.HelloModel;
	import org.bixbite.examples.helloworld.view.HelloView;
	
	/**
	 * Hello World Example
	 */
	public class MainHelloWorld extends Application
	{
		/**
		 * Set your default triad, this Hello World example is not to show you simplicity but a flow.
		 * The simplest way would be to have just view and model as an copy provider.
		 */
		public function MainHelloWorld():void 
		{
			var c:HelloController = new HelloController();
			var m:HelloModel = new HelloModel();
			var v:HelloView = new HelloView();
		}
		
	}
	
}