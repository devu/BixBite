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
	import examples.helloflash.HelloFlash;
	import flash.display.Sprite;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	

	/**
	 * @version  compatibility - 0.6.0
	 */
	public class Ball extends View 
	{
		private var radius		:int = 10;
		private var color		:uint = 0x000000;
		private var _ball		:Sprite;
		
		/**
		 * Constructor
		 */
		public function Ball() 
		{
			
		}
		
		override public function init():void 
		{
			createContext();
		}
		
		private function createContext():void 
		{
			_ball = new Sprite();
			_ball.name = "ball";
			_ball.alpha = 0.75;
			_ball.useHandCursor = true;
			_ball.buttonMode = true;
			
			draw(0x000000, 10);
			
			addSlot(HelloFlash.SHUFFLE, shuffle);
			addSlot(HelloFlash.RED_BALL, onMakeBallRed);
		}
		
		private function onMakeBallRed(s:Signal):void
		{
			draw(0xFF1100, radius++);
		}
		
		private function shuffle(s:Signal):void
		{
			draw(Math.random() * uint.MAX_VALUE, radius++);
		}
		
		private function draw(color:uint, radius:int):void
		{
			_ball.graphics.clear();
			_ball.graphics.beginFill(color);
			_ball.graphics.drawCircle(0, 0, radius);
		}
		
		public function get x():Number { return _ball.x };
		public function set x(value:Number):void { _ball.x = value };
		
		public function get y():Number { return _ball.y };
		public function set y(value:Number):void { _ball.y = value };
		
		public function get context():Sprite 
		{
			return _ball;
		}
		
	}

}