package org.bixbite.framework.modules.deeplinking.transponder 
{
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class DeepLinkingTrans extends Transponder 
	{
		
		public function DeepLinkingTrans() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
		}
		
	}

}