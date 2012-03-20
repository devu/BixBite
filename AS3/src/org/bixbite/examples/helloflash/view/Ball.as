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

package org.bixbite.examples.helloflash.view 
{
	import flash.display.Sprite;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	import org.bixbite.framework.view.DisplayView;

	/**
	 * @version  compatibility - 0.4.1
	 */
	public class Ball extends DisplayView 
	{
		private var component	:Sprite;
		private var radius		:int = 10;
		private var color		:uint = 0x000000;
		
		/**
		 * Constructor
		 */
		public function Ball() 
		{
			
		}
		
		override public function init():void 
		{
			component = new Sprite();
			component.name = "ball";
			component.alpha = 0.75;
			component.useHandCursor = true;
			component.buttonMode = true;
			
			context = component;
			
			draw(0x000000, 10);
			
			addSlot(BallSignal.SHUFFLE, shuffle);
			addSlot(BallSignal.RED_BALL, onMakeBallRed);
		}
		
		private function onMakeBallRed(s:ISignal):void 
		{
			draw(0xFF1100, radius++);
		}
		
		/**
		 * Wee will stick to RL implementation of this bit, but having Proper Model in place we should redraw this view with already known values provided by signal.
		 * View should not perform any calucaltions!
		 * @param	s signal recieved from ... view should not care at all.
		 */
		private function shuffle(s:ISignal):void
		{
			draw(Math.random() * uint.MAX_VALUE, radius++);
		}
		
		/**
		 * Notice, we using already Classic version of framework. By using DisplayView graphics are already exposed, so you don't have to operate directly on component.
		 * This is because graphics will be consistent across many diferent branches. It means, unified way to draw stuff regardless of its implementation. Bitmap Blitting, Custom Display List or even Stage3D.
		 */
		private function draw(color:uint, radius:int):void
		{
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawCircle(0, 0, radius);
		}
		
		/**
		 * We using Decorator Pattern to deal with native DisplayObjects, is up to you what you will expose to the application interface.
		 * Do you need to know rotationZ or hitArea of this bit in our example? I don't think so... View by Decoration automatically becomes mediator of this element, but has nothing to do with any kind of logic.
		 */
		public function get x():Number { return component.x };
		public function set x(value:Number):void { component.x = value };
		
		public function get y():Number { return component.y };
		public function set y(value:Number):void { component.y = value };
		
	}

}