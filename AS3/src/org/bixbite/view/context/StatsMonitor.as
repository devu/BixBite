/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.view.context 
{
	import org.bixbite.core.Context;
	
	/**
	 * @langversion	3.0
	 */
	public class StatsMonitor extends Context 
	{
		override public function init():void 
		{
			draw();
		}
		
		override public function draw():void
		{
			gl.clear();
			gl.beginFill(0x000000, 0.8);
			gl.drawRect(0, 0, 310, 56);
		}
		
	}

}