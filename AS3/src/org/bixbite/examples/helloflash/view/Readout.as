package org.bixbite.examples.helloflash.view 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import org.bixbite.classic.view.DisplayView;
	import org.bixbite.classic.view.DisplayViewContainer;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	
	public class Readout extends DisplayView
	{
		private var textField:TextField;
		private var count:int = 0;
		
		public function Readout() 
		{
			
		}
		
		override public function init():void 
		{
			textField = new TextField()
			stage.addChild(textField);
			
			addSlot(BallSignal.CREATE_BALL, onBallCreate);
		}
		
		private function onBallCreate(s:ISignal):void 
		{
			textField.text = "Click count:" + count++;
		}
	}

}