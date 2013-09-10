package org.bixbite.framework.view 
{
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.context.Window;
	/**
	 * ...
	 * @author devu
	 */
	public class UIWindow extends View 
	{
		private var ctx:Window;
		
		override public function init():void 
		{
			trace(this, "init");
			addSlot(UISignal.SHOW, onShow);
			addSlot(UISignal.HIDE, onHide);
		}
		
		private function onShow(s:Signal):void 
		{
			trace(this, "show");
			if(ctx == null){
				ctx = Window(registerContext("window", Window));
			}
			
			ctx.draw();
			addContext("window", "stage");
		}
		
		private function onHide(s:Signal):void 
		{
			trace(this, "hide");
		}
		
	}

}