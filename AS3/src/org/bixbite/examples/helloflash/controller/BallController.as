package org.bixbite.examples.helloflash.controller 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.bixbite.classic.view.StageView;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	import org.bixbite.examples.helloflash.view.Ball;
	
	public class BallController extends Model 
	{
		private var topView:StageView;
		
		public function BallController(topView:StageView)
		{
			this.topView = topView;
		}
		
		override public function init():void 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			addSlot(BallSignal.CREATE_BALL, onCreateBall);
		}
		
		// Add a Ball to the view
		private function onCreateBall(s:ISignal):void
		{
			var ball:Ball = new Ball();
			ball.x = Math.random() * 500;
			ball.y = Math.random() * 375;
			topView.addView(ball);
		}
		
		/**
		 * Controll, yes, this is what controller is for, capture user input and perform GUI logic!
		 *I am really disapointed to see this bit in View by RL. In fact RL and PureMVC bad habbits are determined by using view mediators to do Controllers job.
		 * @param	e native event listener.
		 */
		private function onMouseDown(e:MouseEvent):void 
		{
			var balls:Array = stage.getObjectsUnderPoint(new Point(stage.mouseX, stage.mouseY));
			balls.reverse();
			
			for each(var b:DisplayObject in balls){
				if (b.name == "ball") sendSignal(BallSignal.POKE);
				return;
			}
		}
		
	}

}