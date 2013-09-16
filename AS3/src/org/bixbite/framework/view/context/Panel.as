/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view.context 
{
	import org.bixbite.core.Context;
	
	/**
	 * @langversion	3.0
	 */
	public class Panel extends Context
	{
		private var w:Number = 100;
		private var h:Number = 100;
		
		override public function init():void 
		{
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(0xEAEAEA, 1);
			graphics.drawRect(0, 0, w, h);
		}
		
		public function setPosition(x:Number, y:Number):void 
		{
			this.x = x;
			this.y = y;
		}
		
		public function setSize(w:Number, h:Number):void 
		{
			this.w = w;
			this.h = h;
		}
		
	}

}