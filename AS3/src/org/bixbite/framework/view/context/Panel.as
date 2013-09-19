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
	public class Panel extends UIContextContainer
	{
		
		override public function init():void 
		{
			
		}
		
		override public function dispose():void 
		{
			graphics.clear();
		}
		
		override public function draw():void
		{
			graphics.clear();
			
			if (border > 0){
				graphics.beginFill(borderColor, opacity);
				graphics.drawRect(margin[3], margin[0], width - (margin[1] + margin[3]), height - (margin[0] + margin[2]));
			}
			
			graphics.beginFill(color, opacity);
			graphics.drawRect(margin[3] + border, margin[0] + border, width - (border * 2) - (margin[1] + margin[3]), height - (border * 2) - (margin[0] + margin[2]));
		}
		
	}

}