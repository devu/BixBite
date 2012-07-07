package org.bixbite.framework.modules.deeplinking.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.modules.deeplinking.DeepLinking;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class InitialiseDeepLinking extends Behaviour 
	{
		
		public function InitialiseDeepLinking() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			
		}
		
		override public function execute(s:ISignal):void 
		{
			trace(this, "execute");
			sendRequest(DeepLinking.INIT_JS_API, s.params);
		}
		
	}

}