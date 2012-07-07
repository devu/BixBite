package org.bixbite.framework.modules.deeplinking.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.modules.deeplinking.data.DeepLinkingData;
	import org.bixbite.framework.modules.deeplinking.DeepLinking;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class OnChange extends Behaviour 
	{
		
		public function OnChange() 
		{
			
		}
		
		override public function init():void 
		{
			addResponder(DeepLinking.ON_CHANGE, onData);
		}
		
		private function onData(s:ISignal):void 
		{
			trace(this, "onData data", s.params);
		}
		
		override public function execute(s:ISignal):void 
		{
			trace(this, "execute");
		}
		
	}

}