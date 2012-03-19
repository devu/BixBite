package org.bixbite.examples.helloflash.model 
{
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	
	public class HelloFlashModel extends Model 
	{
		
		private var ballSignal	:BallSignal;
		private var count		:int = 0;
		
		/**
         * In RL original example there is no Model of application provided. 
         * It's a Model responsibility to describe environment that application live in. 
		 * Model is not only data provider! By definition modelling things, so it must specify some rules of the game.
         */
		public function HelloFlashModel() 
		{
			
		}
		
		override public function init():void
		{
			ballSignal = new BallSignal();
			attachSignal(ballSignal);
			
			addSlot(BallSignal.POKE, onPoke);
			
			count = 1;
			ballSignal.count = count;
			sendSignal(BallSignal.CREATE_BALL);
		}
		
		/**
		 * Is up to Model to decide what to do with this situation. In this case Increase a counter.
		 * It is Model manages state of application, so is up to Model to decide how many you can be generated.
		 * It can send his value to view if needed to display.
		 * 
		 * Consider this, if you need to do something diferent every 10 balls being generated. You have to refactor lots of things. View no longer can count! 
		 * Where you going to put this, into Controller? How you going to send this information from there in order to display count? Stilldoable this way.
		 * Now, what if every 10 steps is depend of data coming from external xml? You going to refactor this again because Model will get ivolved.
		 * So why not do this correctly at first place and have open way for changes? If RL needs to reproduce this example in current implementation is in even bigger trouble.
		 * @param	s
		 */
		private function onPoke(s:ISignal):void 
		{
			count++;
			ballSignal.count = count;
			
			if ((count % 10) == 0){
				sendSignal(BallSignal.CREATE_BALL);
				sendSignal(BallSignal.RED_BALL);
			} else {
				sendSignal(BallSignal.CREATE_BALL);
				sendSignal(BallSignal.SHUFFLE);
			}
		}
	}
}