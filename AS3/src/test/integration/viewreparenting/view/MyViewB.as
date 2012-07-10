package test.integration.viewreparenting.view 
{
	import org.bixbite.framework.view.DisplayViewContainer;
	
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
			
			graphics.clear();
			graphics.beginFill(0x008800);
			graphics.drawRect(0, 0, 100, 100);
			
			context.x = 150;
			context.y = 150;
			
			setContext("ViewB", context);
		}
		
	}

}