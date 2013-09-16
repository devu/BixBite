/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.view 
{
	import examples.helloflash.HelloFlash;
	import examples.helloflash.view.context.BallContext;
	import flash.display.Sprite;
	import org.bixbite.core.ContextContainer;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;

	/**
	 * @langversion	3.0
	 */
	public class BallView extends View 
	{
		private var radius		:int = 10;
		private var color		:uint = 0x000000;
		
		private var ball		:BallContext;
		
		/**
		 * Constructor
		 */
		public function BallView() 
		{
			
		}
		
		override public function init():void 
		{
			ball = BallContext(registerContext("ball", BallContext));
			ball.name = "ball";
			ball.x = 50 + Math.random() * 500;
			ball.y = 50 + Math.random() * 375;
			
			getContainer("app").add(ball);
			
			addSlot(HelloFlash.SHUFFLE, shuffle);
			addSlot(HelloFlash.RED_BALL, onMakeBallRed);
		}
		
		private function onMakeBallRed(s:Signal):void
		{
			ball.drawCirlce(0xFF1100, radius++);
		}
		
		private function shuffle(s:Signal):void
		{
			ball.drawCirlce(Math.random() * uint.MAX_VALUE, radius++);
		}
	}

}