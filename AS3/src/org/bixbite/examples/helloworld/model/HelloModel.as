package org.bixbite.examples.helloworld.model 
{
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	import org.bixbite.examples.helloworld.signal.HelloSignal;
	
	/**
	 * This model is a copy holder that will reponse on 2 diferent signals. Don't care who is calling, will respond as soon as a signal has been recieved.
	 */
	public class HelloModel extends Model 
	{
		private var helloSignal:HelloSignal;
		
		public function HelloModel() 
		{
			
		}
		
		override public function init():void 
		{
			helloSignal = new HelloSignal();
			attachSignal(helloSignal);
			
			addSlot("getCopyRequest", onCopyRequest);
			addSlot("replaceCopy", onReplaceCopy);
		}
		
		private function onCopyRequest(s:ISignal):ISignal 
		{
			helloSignal.copy = "Hello World";
			return signal
		}
		
		private function onReplaceCopy(s:ISignal):void 
		{
			helloSignal.copy = "Hello Bixbite";
			sendSignal("copyReplaced");
		}
		
	}

}