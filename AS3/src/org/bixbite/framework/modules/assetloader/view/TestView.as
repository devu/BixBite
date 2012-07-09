package org.bixbite.framework.modules.assetloader.view 
{
	import org.bixbite.framework.view.DisplayViewContainer;
	import org.bixbite.framework.view.SWFAsset;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestView extends DisplayViewContainer 
	{
		
		public function TestView() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			//var myAsset:SWFAsset = new SWFAsset("test");
			//addView(myAsset);
			//myAsset.load();
		}
		
	}

}