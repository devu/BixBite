/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view.context 
{
	import org.bixbite.framework.view.context.Context;
	
	/**
	 * @langversion	3.0
	 */
	public class StatsMonitor extends Context 
	{
		override public function init():void 
		{
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		override public function draw():void
		{
			graphics.clear();
			graphics.beginFill(0x000000, 0.8);
			graphics.drawRect(0, 0, 310, 56);
		}
		
		override public function dispose():void 
		{
			graphics.clear();
		}
		
	}

}