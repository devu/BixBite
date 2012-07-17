package test.integration.viewreparenting.view 
{
	import org.bixbite.core.Signal;
	import org.bixbite.framework.view.DisplayViewContainer;
	import org.bixbite.framework.view.ViewSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MyViewA extends DisplayViewContainer 
	{
		
		public function MyViewA() 
		{
			
		}
		
		override public function init():void 
		{
			super.init();
			
			context.name = "ViewA";
			context.x = 100;
			context.y = 100;
			
			graphics.clear();
			graphics.beginFill(0x880000);
			graphics.drawRect(0, 0, 200, 200);
			
			trace(this, "init", stageView);
			
			addSlot(ViewSignal.ADDED, onViewAdded);
		}
		
		private function onViewAdded(s:Signal):void 
		{
			trace(this, "added", stageView);
		}
		
	}

}