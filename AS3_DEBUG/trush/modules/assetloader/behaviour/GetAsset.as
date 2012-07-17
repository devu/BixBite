package org.bixbite.framework.modules.assetloader.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.modules.assetloader.AssetLoader;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class GetAsset extends Behaviour 
	{
		
		public function GetAsset() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			addResponder(AssetLoader.ASSET_READY, onAssetReady);
		}
		
		private function onAssetReady(s:ISignal, data:IData):void 
		{
			trace(this, "onAssetReady", data);
			sendSignal("onAssetReady", [data]);
		}
		
		override public function execute(s:ISignal):void 
		{
			trace(this, "execute");
			sendRequest(AssetLoader.GET_ASSET, s.params);
		}
		
	}

}