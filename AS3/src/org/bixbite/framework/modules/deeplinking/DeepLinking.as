package org.bixbite.framework.modules.deeplinking 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.deeplinking.behaviour.InitialiseDeepLinking;
	import org.bixbite.framework.modules.deeplinking.behaviour.OnChange;
	import org.bixbite.framework.modules.deeplinking.behaviour.SetAddress;
	import org.bixbite.framework.modules.deeplinking.data.DeepLinkingData;
	import org.bixbite.framework.modules.deeplinking.transponder.DeepLinkingTrans;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class DeepLinking extends Compound 
	{
		public static const INIT			:String = "DeepLinking_init";
		public static const INIT_JS_API		:String = "DeepLinking_initJSAPI";
		public static const SET_ADDRESS		:String = "DeepLinking_setAddress";
		public static const ON_CHANGE		:String = "DeepLinking_onChange";
		
		public function DeepLinking() 
		{
			var d:DeepLinkingData 	= new DeepLinkingData();
			var t:DeepLinkingTrans 	= new DeepLinkingTrans();
			
			addBehaviour(DeepLinking.INIT, InitialiseDeepLinking);
			addBehaviour(DeepLinking.ON_CHANGE, OnChange);
			addBehaviour(DeepLinking.SET_ADDRESS, SetAddress);
			
			startup(DeepLinking.INIT, ["bixbite"]);
			//startup(DeepLinking.SET_ADDRESS, ["http://www.flaemo.com"]);
		}
		
	}

}