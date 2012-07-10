package test.integration.viewreparenting.view 
{
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.view.DisplayViewContainer;
	import org.bixbite.framework.view.ViewSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MyViewB extends DisplayViewContainer 
	{
		
		public function MyViewB() 
		{
			
		}
		
		override public function init():void 
		{
			super.init();
			
			context.name = "ViewB";
			context.x = 150;
			context.y = 150;
			
			graphics.clear();
			graphics.beginFill(0x008800);
			graphics.drawRect(0, 0, 100, 100);
			
			trace(this, "init", stageView);
			
			addSlot(ViewSignal.ADDED, onViewAdded);
		}
		
		private function onViewAdded(s:ISignal):void 
		{
			trace(this, "added", stageView);
		}
		
	}

}