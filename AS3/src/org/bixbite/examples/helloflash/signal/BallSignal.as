package org.bixbite.examples.helloflash.signal 
{
	import org.bixbite.core.Signal;
	
	public class BallSignal extends Signal 
	{
		public static const CREATE_BALL			:String = "createBall";
		public static const RED_BALL			:String = "makeRedBall";
		public static const POKE				:String = "poke";
		public static const SHUFFLE				:String = "shuffle";
		
		public var count:int = 0;
	}

}