package org.bixbite.framework.view.context 
{
	import org.bixbite.framework.view.Context2D;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class StatsMonitor extends Context2D 
	{
		
		public function StatsMonitor() 
		{
			graphics.beginFill(0x000000, 0.8);
			graphics.drawRect(0, 0, 310, 56);
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		override public function dispose():void 
		{
			graphics.clear();
		}
		
	}

}