package org.bixbite.framework.factories 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TextFactory 
	{
		private static var _instance:TextFactory = new TextFactory();
		
		public function TextFactory() 
		{
			
		}
		
		static public function get instance():TextFactory 
		{
			return _instance;
		}
		
		public function createSimpleText(container:DisplayObjectContainer, x:Number, y:Number, w:Number = 100, h:Number = 100, color:uint = 0xFFFFFF):TextField
		{
			var tf:TextFormat = new TextFormat("tahoma", 9, color);
			
			var t:TextField = new TextField();
			t.mouseEnabled = false;
			t.selectable = false;
			t.x = x;
			t.y = y;
			t.width = w;
			t.height = h;
			t.defaultTextFormat = tf;
			
			container.addChild(t);
			
			return t;
		}
		
	}

}