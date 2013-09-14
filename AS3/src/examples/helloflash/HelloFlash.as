/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash 
{
	import examples.helloflash.behaviour.Poke;
	import examples.helloflash.HelloFlash;
	import examples.helloflash.transponder.BallTransponder;
	import examples.helloflash.view.HelloFlashView;
	import org.bixbite.core.Compound;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloFlash extends Compound 
	{
		public static const CREATE_BALL			:String = "HelloFlash.CREATE_BALL";
		public static const RED_BALL			:String = "HelloFlash.RED_BALL";
		public static const POKE				:String = "HelloFlash.POKE";
		public static const SHUFFLE				:String = "HelloFlash.SHUFFLE";
		
		public function HelloFlash() 
		{
			
		}
		
		override public function init():void
		{
			register(BallTransponder);
			register(HelloFlashView);
			
			addBehaviour(HelloFlash.POKE, Poke, false, true);
		}
		
	}

}