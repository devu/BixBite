/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view 
{
	
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.interfaces.IContextContainer;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.context.Panel;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UIPanel extends View 
	{
		private var root	:IContextContainer;
		private var ctx		:Panel;
		
		override public function init():void 
		{
			addSlot(UISignal.SHOW, onShow);
			addSlot(UISignal.HIDE, onHide);
			
			addSlot(UISignal.CREATE, onCreated);
		}
		
		private function onCreated(s:Signal):void 
		{
			trace(this, "created");
			var p:Object = s.params;
			
			ctx = Panel(registerContext("panel", Panel));
			ctx.setPosition(p.x, p.y);
			//ctx.setSize(p.w, p.h);
			
			root = getContainer("app");
			root.add(ctx);
			
			ctx.draw();
		}
		
		private function onPanelClosed(s:Signal):void 
		{
			trace(this, "closed");
		}
		
		private function onShow(s:Signal):void 
		{
			trace(this, "show");
		}
		
		private function onHide(s:Signal):void 
		{
			trace(this, "hide");
		}
		
		override public function destroy():void 
		{
			//clean up this class here and then:
			super.destroy();
		}
		
	}
	
}