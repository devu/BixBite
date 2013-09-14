/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.view 
{
	import flash.display3D.Context3D;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.data.UIStyle;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.context.Canvas;
	import org.bixbite.framework.view.context.Context;
	
	/**
	 * @langversion	3.0
	 */
	public class UICanvas extends View 
	{
		private var canvas	:Canvas;
		private var style	:UIStyle;
		
		override public function init():void 
		{
			addSlot(UISignal.INIT, onInit);
			addSlot(StageSignal.ON_RESIZE, onResize);
		}
		
		private function onResize(s:Signal):void 
		{
			canvas.draw();
		}
		
		private function onInit(s:Signal):void 
		{
			canvas = Canvas(registerContext("canvas", Canvas));
			
			style = UIStyle(s.params);
			canvas.color = style.canvasColor;
			canvas.opacity = style.canvasOpacity;
			
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