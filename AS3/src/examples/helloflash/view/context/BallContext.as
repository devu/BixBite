/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.view.context 
{
	import org.bixbite.display.Context;
	
	/**
	 * @langversion	3.0
	 */
	public class BallContext extends Context 
	{
		override public function init():void 
		{
			gl.alpha(0.75);
			body.useHandCursor = true;
			body.buttonMode = true;
		}
		
		override public function draw():void
		{
			drawCircle(0x000000, 10);
		}
		
		public function drawCircle(color:uint, radius:int):void 
		{
			gl.clear();
			gl.beginFill(color,1);
			gl.drawCircle(0, 0, radius);
		}
		
	}

}