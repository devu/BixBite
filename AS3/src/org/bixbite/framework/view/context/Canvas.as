/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view.context 
{
	import org.bixbite.core.ContextContainer;
	
	/**
	 * @langversion	3.0
	 */
	public class Canvas extends UIContextContainer 
	{
		private var w:Number = 100;
		private var h:Number = 100;
		
		override public function init():void 
		{
			trace(this, "init");
			color = 0xEAEAEA;
		}
		
		override public function dispose():void 
		{
			graphics.clear();
		}
		
		override public function draw():void
		{
			graphics.clear();
			graphics.beginFill(color, opacity);
			graphics.drawRect(margin[3] + border, margin[0] + border, width - (border * 2) - (margin[1] + margin[3]), height - (border * 2) - (margin[0] + margin[2]));
			/*
			graphics.beginFill(color, opacity);
			graphics.drawRect(0, 0, width, height);
			*/
		}
		
	}

}