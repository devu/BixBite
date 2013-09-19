/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view 
{
	import org.bixbite.core.ContextContainer;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.context.Canvas;
	
	/**
	 * @langversion	3.0
	 */
	public class UICanvas extends View 
	{
		private var root	:ContextContainer;
		private var ctx		:Canvas;
		
		private var width	:Number;
		private var height	:Number;
		private var x		:Number = 0;
		private var y		:Number = 0;
		
		override public function init():void 
		{
			addSlot(UISignal.INIT, onInit);
			addSlot(DisplaySignal.ON_RESIZE, onResize);
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
		private function onResize(s:Signal):void 
		{
			width = s.params.width;
			height = s.params.height;
			ctx.setSize(width, height);
			ctx.draw();
			
			trace(this, "resize", width, height);
		}
		
		private function onInit(s:Signal):void 
		{
			if (s.params) setParams(s.params);
			
			ctx = Canvas(registerContext("canvas", Canvas));
			root = getContainer("root");
			
			ctx.margin = [10, 10, 10, 10];
			
			width = root.stage.stageWidth;
			height = root.stage.stageHeight;
			ctx.setSize(width, height);
			ctx.draw();
			
			ctx.setPosition(x, y);
			
			root.add(ctx);
		}
		
		private function setParams(p:Object):void 
		{
			x = p.x || 0;
			y = p.y || 0;
		}
	}

}