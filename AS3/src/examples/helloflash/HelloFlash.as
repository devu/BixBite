package examples.helloflash 
{
	import examples.helloflash.HelloFlash;
	import examples.helloflash.behaviour.Poke;
	import examples.helloflash.transponder.BallTransponder;
	import examples.helloflash.view.MainView;
	import org.bixbite.core.Compound;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
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
			register(MainView);
			
			addBehaviour(HelloFlash.POKE, Poke);
		}
		
	}

}