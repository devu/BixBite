package org.examples.view 
{
	import flash.display.Shape;
	import org.bixbite.framework.core.View;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestView extends View 
	{
		private var shape:Shape;
		
		public function TestView() 
		{
			
		}
		
		override public function init():void
		{
			addSlot("updateView", onUpdateView);
		}
		
		override public function create():void 
		{
			shape = new Shape();
			addChild(shape);
		}
		
		private function onUpdateView(s:IValueObject):void 
		{
			// detachSignal("updateView");
			
			shape.x = Math.random() * 800;
			shape.y = Math.random() * 800;
			
			shape.graphics.clear();
			shape.graphics.beginFill(0xFF0000, 1);
			shape.graphics.drawRect(0, 0, 10, 10);
		}
		
	}

}