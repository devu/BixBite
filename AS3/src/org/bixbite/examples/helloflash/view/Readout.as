package org.bixbite.examples.helloflash.view 
{
	import flash.text.TextField;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	import org.bixbite.framework.view.DisplayView;
	
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
			system.stage.addChild(textField);
			
			addSlot(BallSignal.CREATE_BALL, onBallCreate);
		}
		
		private function onBallCreate(s:ISignal):void 
		{
			textField.text = "Click count:" + count++;
		}
	}

}