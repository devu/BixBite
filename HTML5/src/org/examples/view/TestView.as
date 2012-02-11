package org.examples.view 
{
	import flash.display.Shape;
	import flash.display.Sprite;
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
			//Call it Dependency Injection if you like
			
			//This simple view become a leaf view, you can't add anything into it but its content might be any kind of DisplayObject
			//var myContent:Shape = new Shape();
			//var myContent:Sprite = new Sprite();
			
			//You can preset it
			//var myContent:Sprite = new Sprite();
			//myContent.mouseEnabled = false;
			
			//And you can gotoAndStop it :)
			//var myContent:MovieClip = new MovieClip();
			//myContent.gotoAndStop(2);
			
			content = shape = new Shape();
		}
		
		override public function init():void
		{
			addSlot("updateView", onUpdateView);
		}
		
		private function onUpdateView(s:IValueObject):void
		{
			//removeSlot("updateView");
			
			//shape.x = Math.random() * 800;
			//shape.y = Math.random() * 800;
			
			//shape.graphics.clear();
			//shape.graphics.beginFill(0xFF0000, 1);
			//shape.graphics.drawRect(0, 0, 10, 10);
		}
		
	}

}