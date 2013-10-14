package org.bixbite.display 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import org.bixbite.core.interfaces.IContext;
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
		
		public function addChild(child:IContext):IContext
		{
			stage.addChild(child.body);
			return child
		}
		
		public function removeChild(child:IContext):IContext
		{
			stage.removeChild(child.body);
			return child
		}
		
		public function debug(node:XML):void
		{
			
		}
		
	}

}