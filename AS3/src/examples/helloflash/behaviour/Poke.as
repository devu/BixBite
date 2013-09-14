/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.behaviour 
{
	import examples.helloflash.HelloFlash;
	import examples.helloflash.view.BallView;
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * @langversion	3.0
	 */
	public class Poke extends Behaviour 
	{
		private var count		:int = 0;
		
		public function Poke() 
		{
			
		}
		
		override public function execute(s:Signal):void 
		{
			count++;
			
			register(BallView, false);
			sendSignal(HelloFlash.CREATE_BALL, count);
			
			if ((count % 10) == 0){
				sendSignal(HelloFlash.RED_BALL);
			} else {
				sendSignal(HelloFlash.SHUFFLE);
			}
		}
		
	}

}