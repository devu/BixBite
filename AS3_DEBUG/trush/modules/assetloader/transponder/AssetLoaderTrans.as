package org.bixbite.framework.modules.assetloader.transponder 
{
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.modules.assetloader.AssetLoader;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AssetLoaderTrans extends Transponder 
	{
		
		public function AssetLoaderTrans() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			addSlot(AssetLoader.GET_ASSET, onGetAsset);
		}
		
		private function onGetAsset(s:ISignal):void 
		{
			trace(this, "onGetAsset");
			sendSignal(AssetLoader.GET_ASSET, s.params);
		}
		
	}

}