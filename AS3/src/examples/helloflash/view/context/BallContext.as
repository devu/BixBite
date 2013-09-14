package examples.helloflash.view.context 
{
	import org.bixbite.framework.view.context.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class BallContext extends Context 
	{
		
		override public function init():void 
		{
			this.alpha = 0.75;
			this.useHandCursor = true;
			this.buttonMode = true;
		}
		
		public function drawCirlce(color:uint, radius:int):void
		{
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, radius);
		}
		
		override public function draw():void
		{
			drawCirlce(0x000000, 10);
		}
		
	}

}