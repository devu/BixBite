package org.bixbite.framework.modules.assetloader.data 
{
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.modules.assetloader.AssetLoader;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AssetsData extends Data 
	{
		private var items		:Vector.<IAsset> = new Vector.<IAsset>();
		private var queue		:int = 0;
		
		public function AssetsData() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(AssetLoader.REGISTER_ASSET, onRegisterAsset);
			addSlot(AssetLoader.GET_ASSET, onRequestAsset);
		}
		
		private function onRegisterAsset(s:Signal):void 
		{
			var item:IAsset = s.params[0];
			items.push(item);
		}
		
		public function loadItem(id:int):void
		{
			IAsset(items[id]).load(
				
				function onComplete(item:IAsset):void {
					//dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ITEM_COMPLETED, item));
					sendSignal(AssetLoader.ASSET_READY, [item]);
					isQueueComplete();
				}
				,
				function onItemSkip(item:IAsset):void {
					//dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ITEM_SKIPPED, item));
					sendSignal(AssetLoader.ASSET_SKIPPED);
					isQueueComplete();
				}
			);
			
			queue++;
		}
		
		private function isQueueComplete():void
		{
			queue--;
			if (queue == 0) sendSignal(AssetLoader.ALL_COMPLETED); //dispatchEvent(new AssetLoaderEvent(AssetLoaderEvent.ALL_COMPLETED));
		}
		
		private function onRequestAsset(s:Signal):void 
		{
			trace("onRequestAsset:" , s.params);
		}
		
	}

}