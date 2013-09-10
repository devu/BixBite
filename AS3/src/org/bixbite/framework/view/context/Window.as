package org.bixbite.framework.view.context 
{
	/**
	 * ...
	 * @author devu
	 */
	public class Window extends UIContext 
	{
		
		public function Window() 
		{
			
		}
		
		override public function draw():void 
		{
			trace("draw");
			graphics.clear();
			graphics.beginFill(0xEAEAEA, 1);
			graphics.drawRect(0, 0, 100, 100);
		}
		
	}

}