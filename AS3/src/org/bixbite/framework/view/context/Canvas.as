package org.bixbite.framework.view.context 
{
	/**
	 * ...
	 * @author devu
	 */
	public class Canvas extends Context 
	{
		override public function init():void 
		{
			
		}
		
		override public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(0xEAEAEA, 1);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		}
		
		override public function dispose():void 
		{
			graphics.clear();
		}
		
	}

}