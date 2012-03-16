package org.bixbite.examples.helloflash.model 
{
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	import org.bixbite.examples.helloflash.signal.AppSignal;
	import org.bixbite.examples.helloflash.signal.BallSignal;
	
	public class HelloFlashModel extends Model 
	{
		
		/**
         * In RL original example there is no Model of application provided. This is due to misconception of use MVC paradigm.
         * It's a Model responsibility to describe environment application live in. Model is not only data provider! by definition modelling things, so it must specify some rules of the game.
         */
		public function HelloFlashModel() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(BallSignal.POKE, onPoke);
			addSlot(AppSignal.STARTUP, onStartup);
		}
		
		private function onStartup(s:ISignal):void
		{
			sendSignal(BallSignal.CREATE_BALL);
		}
		
		/**
		 * Is up to Model to decide what to do with this situation, no Controller for sure not View.
		 * @param	s
		 */
		private function onPoke(s:ISignal):void 
		{
			sendSignal(BallSignal.CREATE_BALL);
		}
		
	}

}