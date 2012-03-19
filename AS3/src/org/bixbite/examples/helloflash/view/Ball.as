package org.bixbite.examples.helloflash.view 
{
	import flash.display.Sprite;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	import org.bixbite.framework.view.DisplayView;

	public class Ball extends DisplayView 
	{
		private var component	:Sprite;
		private var radius		:int = 10;
		private var color		:uint = 0x000000;

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
			
			content = component;
			
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