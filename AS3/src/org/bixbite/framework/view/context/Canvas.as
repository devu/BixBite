/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view.context 
{
	/**
	 * @langversion	3.0
	 */
	public class Canvas extends Context 
	{
		public var color	:uint = 0xFFFFFF;
		public var opacity	:Number = 1;
		
		override public function init():void 
		{
			
		}
		
		override public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(color, opacity);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		}
		
		override public function dispose():void 
		{
			graphics.clear();
		}
		
	}

}