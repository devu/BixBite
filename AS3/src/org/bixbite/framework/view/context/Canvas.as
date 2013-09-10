package org.bixbite.framework.view.context 
{
	/**
	 * ...
	 * @author devu
	 */
	public class Canvas extends Context2D 
	{
		
		public function Canvas() 
		{
			
		}
		
		override public function draw():void 
		{
			trace(this, "draw");
			graphics.clear();
			graphics.beginFill(0xEAEAEA, 1);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		}
		
	}

}