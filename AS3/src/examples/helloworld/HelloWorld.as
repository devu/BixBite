package examples.helloworld 
{
	import examples.helloworld.behaviour.CopyHandler;
	import examples.helloworld.data.HelloData;
	import examples.helloworld.transponder.HelloTransponder;
	import examples.helloworld.view.RootView;
	import org.bixbite.core.Compound;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class HelloWorld extends Compound 
	{
		public static const INIT				:String = "HelloWorld.INIT";
		public static const COPY_REQUEST		:String = "HelloWorld.COPY_REQUEST";
		public static const UPDATE_COPY			:String = "HelloWorld.UPDATE_COPY";
		public static const GET_DEFAULT_COPY	:String = "HelloWorld.GET_DEFAULT_COPY";
		public static const SET_COPY			:String = "HelloWorld.SET_COPY";
		
		public function HelloWorld() 
		{
			
		}
		
		override public function init():void 
		{
			register(HelloTransponder);
			register(HelloData);
			register(RootView);
			
			addBehaviour(HelloWorld.UPDATE_COPY, CopyHandler);
			
			sendSignal(HelloWorld.INIT, { max:20 } );
		}
		
	}

}