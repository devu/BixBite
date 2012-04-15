/**The MIT License

@copy (c) 2012 Devu Design Limited, Daniel Wasilewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package examples.helloflash.view 
{
	import examples.helloflash.Signals;
	import flash.display.Sprite;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.view.DisplayView;

	/**
	 * @version  compatibility - 0.5.1
	 */
	public class Ball extends DisplayView 
	{
		private var radius		:int = 10;
		private var color		:uint = 0x000000;
		private var ball:Sprite;
		
		/**
		 * Constructor
		 */
		public function Ball() 
		{
			
		}
		
		override public function init():void 
		{
			ball = new Sprite();
			ball.alpha = 0.75;
			ball.useHandCursor = true;
			ball.buttonMode = true;
			
			draw(0x000000, 10);
			
			setContext("ball", ball);
			
			addSlot(Signals.SHUFFLE, shuffle);
			addSlot(Signals.RED_BALL, onMakeBallRed);
		}
		
		private function onMakeBallRed(s:ISignal):void 
		{
			draw(0xFF1100, radius++);
		}
		
		private function shuffle(s:ISignal):void
		{
			draw(Math.random() * uint.MAX_VALUE, radius++);
		}
		
		private function draw(color:uint, radius:int):void
		{
			ball.graphics.clear();
			ball.graphics.beginFill(color);
			ball.graphics.drawCircle(0, 0, radius);
		}
		
		public function get x():Number { return context.x };
		public function set x(value:Number):void { context.x = value };
		
		public function get y():Number { return context.y };
		public function set y(value:Number):void { context.y = value };
		
	}

}