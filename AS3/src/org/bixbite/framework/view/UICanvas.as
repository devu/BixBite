package org.bixbite.framework.view 
{
	import flash.display3D.Context3D;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.context.Canvas;
	import org.bixbite.framework.view.context.Context;
	
	/**
	 * ...
	 * @author devu
	 */
	public class UICanvas extends View 
	{
		private var canvas:IContext;
		
		override public function init():void 
		{
			trace(this, "init");
			addSlot(UISignal.INIT, onInit);
			addSlot(StageSignal.ON_RESIZE, onResize);
		}
		
		private function onResize(s:Signal):void 
		{
			canvas.draw();
		}
		
		private function onInit(s:Signal):void 
		{
			canvas = registerContext("canvas", Canvas);
			addContext("canvas", "app");
		}
		
		override public function onContextAdded():void 
		{
			canvas.draw();
		}
		
		override public function onContextRemoved():void 
		{
			canvas.dispose();
		}
	}

}