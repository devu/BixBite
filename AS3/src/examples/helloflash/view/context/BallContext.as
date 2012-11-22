package examples.helloflash.view.context 
{
	import org.bixbite.framework.view.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class BallContext extends Context 
	{
		
		public function BallContext() 
		{
			this.alpha = 0.75;
			this.useHandCursor = true;
			this.buttonMode = true;
		}
		
		public function draw(color:uint, radius:int):void
		{
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, radius);
		}
		
	}

}