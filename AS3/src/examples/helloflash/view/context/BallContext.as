/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.view.context 
{
	import org.bixbite.core.Context;
	
	/**
	 * @langversion	3.0
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
		
		public function draw():void
		{
			drawCirlce(0x000000, 10);
		}
		
	}

}