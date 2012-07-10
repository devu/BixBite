package test.integration.viewreparenting.view 
{
	import org.bixbite.framework.view.DisplayViewContainer;
	
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
			
			graphics.clear();
			graphics.beginFill(0x880000);
			graphics.drawRect(0, 0, 200, 200);
			
			context.x = 100;
			context.y = 100;
		}
		
	}

}