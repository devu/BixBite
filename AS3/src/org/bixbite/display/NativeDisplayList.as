package org.bixbite.display 
{
	import flash.display.Stage;
	import org.bixbite.core.Context;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class NativeDisplayList implements IDisplayList 
	{
		private var stage:Stage;
		
		public function NativeDisplayList(stage:Stage) 
		{
			this.stage = stage;
		}
		
		public function addChild(child:Context):Context
		{
			stage.addChild(child.body);
			return child
		}
		
		public function removeChild(child:Context):Context
		{
			stage.removeChild(child.body);
			return child
		}
		
	}

}