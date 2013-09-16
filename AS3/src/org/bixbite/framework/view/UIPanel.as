/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view 
{
	
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.context.Panel;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UIPanel extends View 
	{
		
		override public function init():void 
		{
			addSlot(UISignal.SHOW, onShow);
			addSlot(UISignal.HIDE, onHide);
			
			addSlot(UISignal.CREATE, onWindowCreated);
			addSlot(UISignal.CLOSE, onWindowClosed);
		}
		
		private function onWindowCreated(s:Signal):void 
		{
			var ctx:Panel = Panel(registerContext("panel", Panel));
			addContext("panel", "app");
			ctx.draw();
		}
		
		private function onWindowClosed(s:Signal):void 
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