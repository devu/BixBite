/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view.context 
{
	/**
	 * @langversion	3.0
	 */
	public class Window extends Context
	{
		
		override public function init():void 
		{
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		override public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(0xEAEAEA, 1);
			graphics.drawRect(0, 0, 100, 100);
		}
		
	}

}