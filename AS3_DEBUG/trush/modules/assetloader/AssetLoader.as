package org.bixbite.framework.modules.assetloader 
{
	import flash.display.DisplayObjectContainer;
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.assetloader.behaviour.GetAsset;
	import org.bixbite.framework.modules.assetloader.behaviour.RegisterAsset;
	import org.bixbite.framework.modules.assetloader.data.AssetsData;
	import org.bixbite.framework.modules.assetloader.transponder.AssetLoaderTrans;
	import org.bixbite.framework.modules.assetloader.view.TestView;
	import org.bixbite.framework.view.StageView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AssetLoader extends Compound 
	{
		public static const SWF					:String = "AssetType.SWF";
		public static const REGISTER_ASSET		:String = "AssetLoader.REGISTER_ASSET";
		public static const GET_ASSET			:String = "AssetLoader.GET_ASSET";
		public static const ASSET_READY			:String = "AssetLoader.ASSET_READY";
		public static const ASSET_SKIPPED		:String = "AssetLoader.ASSET_SKIPPED";
		public static const ALL_COMPLETED		:String = "AssetLoader.ALL_COMPLETED";
		
		private var transponder	:AssetLoaderTrans;
		private var data		:AssetsData;
		
		public function AssetLoader() 
		{
			var data:AssetsData = new AssetsData();
			transponder 		= new AssetLoaderTrans();
			
			addBehaviour(AssetLoader.REGISTER_ASSET, RegisterAsset);
			addBehaviour(AssetLoader.GET_ASSET, GetAsset);
			
			var stageView:StageView = new StageView(stage);
			
			var testView:TestView = new TestView();
			stageView.addView(testView);
		}
	}

}