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
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.context.Window;
	
	/**
	 * @langversion	3.0
	 */
	public class UIWindow extends View 
	{
		private var ctx:Window;
		
		override public function init():void 
		{
			addSlot(UISignal.SHOW, onShow);
			addSlot(UISignal.HIDE, onHide);
			
			addSlot(UISignal.CREATE, onWindowCreated);
			addSlot(UISignal.CLOSE, onWindowClosed);
			
			ctx = Window(registerContext("window", Window));
		}
		
		private function onWindowCreated(s:Signal):void 
		{
			//addContext("window", "canvas");
			var root:IContextContainer = getContainer("app");
			ctx.draw();
		}
		
		private function onWindowClosed(s:Signal):void 
		{
			trace(this,"closed");
		}
		
		private function onShow(s:Signal):void 
		{
			ctx.draw();
		}
		
		private function onHide(s:Signal):void 
		{
			trace(this, "hide");
		}
		
	}

}