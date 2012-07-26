package org.bixbite.framework.behaviour 
{
	import flash.display.DisplayObject;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class DisplayListRemoveContext extends DisplayListGet 
	{
		
		public function DisplayListRemoveContext() 
		{
			
		}
		
		override public function execute(s:Signal):void 
		{
			var context:DisplayObject = list[s.params.name];
			context.parent.removeChild(context);
		}
		
	}

}