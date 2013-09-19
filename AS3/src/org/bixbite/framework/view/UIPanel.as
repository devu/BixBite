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
	import org.bixbite.framework.view.context.Panel;
	import org.bixbite.framework.view.context.UIContextContainer;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UIPanel extends View 
	{
		private var root	:UIContextContainer;
		private var ctx		:Panel;
		
		private var width	:Number;
		private var wp		:Boolean = false;
		private var height	:Number;
		private var hp		:Boolean = false;
		private var x		:Number = 0;
		private var y		:Number = 0;
		
		override public function init():void 
		{
			addSlot(UISignal.CREATE, onCreated);
			addSlot(DisplaySignal.ON_RESIZE, onResize);
		}
		
		override public function destroy():void 
		{
			//clean up this class here and then:
			super.destroy();
		}
		
		private function onResize(s:Signal):void 
		{
			var tw:Number = (wp) ? width * root.width / 100 : width;
			var th:Number = (hp) ? height * root.height / 100 : height;
			
			ctx.setSize(Math.round(tw), Math.round(th));
			ctx.draw();
		}
		
		private function onCreated(s:Signal):void 
		{
			var p:Object = s.params;
			
			root = UIContextContainer(getContainer(p.container || "canvas"));
			ctx = Panel(registerContext(p.name, Panel));
			ctx.clone(root);
			
			ctx.color = 0xFFFFFF;
			ctx.margin = p.margin || [0, 0, 0, 0];
			
			wp = (p.width is String) ? true : false;
			width = parseFloat(p.width);
			
			hp = (p.height is String) ? true : false;
			height = parseFloat(p.height);
			
			var tw:Number = (wp) ? width * root.width / 100 : width;
			var th:Number = (hp) ? height * root.height / 100 : height;
			
			x = p.x || 0;
			y = p.y || 0;
			
			ctx.setSize(Math.round(tw), Math.round(th));
			ctx.setPosition(Math.round(x), Math.round(y));
			ctx.draw();
			
			root.add(ctx);
		}
	}
	
}