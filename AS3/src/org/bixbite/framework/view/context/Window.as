package org.bixbite.framework.view.context 
{
	/**
	 * ...
	 * @author devu
	 */
	public class Window extends UIContext
	{
		
		override public function init():void 
		{
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		override public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(0xEAEAEA, 1);
			graphics.drawRect(0, 0, 100, 100);
		}
		
	}

}