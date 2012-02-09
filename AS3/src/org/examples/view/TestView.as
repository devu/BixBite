package org.examples.view 
{
	import org.bixbite.framework.core.View;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestView extends View 
	{
		
		public function TestView() 
		{
			
		}
		
		override public function init():void
		{
			addSlot("updateView", onUpdateView);
		}
		
		private function onUpdateView(s:IValueObject):void 
		{
			// detachSignal("updateView");
			
			this.x = Math.random() * 800;
			this.y = Math.random() * 800;
			
			graphics.clear();
			graphics.beginFill(0xFF0000, 1);
			graphics.drawRect(0, 0, 10, 10);
		}
		
	}

}