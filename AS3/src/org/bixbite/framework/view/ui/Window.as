package org.bixbite.framework.view.ui 
{
	import org.bixbite.framework.view.DisplayViewContainer;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Window extends DisplayViewContainer 
	{
		private var xpos:Number;
		private var ypos:Number;
		
		public function Window(parentView:DisplayViewContainer, xpos:Number = 0, ypos:Number = 0) 
		{
			this.parentView = parentView;
			
			this.xpos = xpos;
			this.ypos = ypos;
			
			super();
		}
		
		override public function init():void 
		{
			trace(this, "init");
			super.init();
			
			parentView.addView(this);
			
			draw();
		}
		
		private function draw():void 
		{
			trace(this, "draw");
			
			graphics.clear();
			graphics.beginFill(0x000000);
			graphics.drawRect(0, 0, 100, 100);
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(1, 1, 98, 98);
		}
		
	}

}