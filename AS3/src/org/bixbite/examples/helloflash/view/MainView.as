package org.bixbite.examples.helloflash.view 
{
	import flash.text.TextField;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	import org.bixbite.framework.view.StageView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MainView extends StageView 
	{
		private var textField:TextField;
		
		public function MainView() 
		{
			
		}
		
		override public function init():void 
		{
			super.init();
			
			textField = new TextField();
			textField.selectable = false;
			system.stage.addChild(textField);
			
			addSlot(BallSignal.CREATE_BALL, onCreateBall);
		}
		
		// Add a Ball to the view
		private function onCreateBall(s:BallSignal):void
		{
			textField.text = "Click count:" + s.count;
			
			var ball:Ball = new Ball();
			ball.x = Math.random() * 500;
			ball.y = Math.random() * 375;
			addView(ball);
		}
		
	}

}