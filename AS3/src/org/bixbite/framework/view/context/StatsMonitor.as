package org.bixbite.framework.view.context 
{
	import org.bixbite.framework.view.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class StatsMonitor extends Context 
	{
		
		public function StatsMonitor() 
		{
			graphics.beginFill(0x000000, 0.8);
			graphics.drawRect(0, 0, 310, 56);
			mouseEnabled = false;
			mouseChildren = false;
		}
		
	}

}