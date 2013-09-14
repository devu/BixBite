/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.factories 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * @langversion	3.0
	 */
	public class TextFactory 
	{
		private static var _instance:TextFactory = new TextFactory();
		
		private var formats:Dictionary = new Dictionary();
		
		public function TextFactory() 
		{
			setTextFormat("default");
		}
		
		public static function getInstance():TextFactory
		{
			return _instance
		}
		
		public function setTextFormat(id:String, font:String="tahoma", size:int = 8, color:uint = 0xFFFFFF, align:String = "center"):void
		{
			var tf:TextFormat = new TextFormat(font, size, color);
			
			tf.align = align;
			formats[id] = tf;
		}
		
		public function createText(container:DisplayObjectContainer, format:String, x:Number, y:Number, w:Number = 100, h:Number = 100, color:uint = 0xFFFFFF):TextField
		{
			if (formats[format] == null) format = "default";
			formats[format].color = color;
			
			var t:TextField = new TextField();
			t.mouseEnabled = false;
			t.selectable = false;
			t.x = x;
			t.y = y;
			t.width = w;
			t.height = h;
			t.defaultTextFormat = formats[format];
			
			container.addChild(t);
			
			return t;
		}
		
		public function createEmbededText(container:DisplayObjectContainer, format:String, x:Number, y:Number, w:Number = 100, h:Number = 100, color:uint = 0xFFFFFF):TextField
		{
			if (formats[format] == null) format = "default";
			formats[format].color = color;
			
			var t:TextField = new TextField();
			t.mouseEnabled = false;
			t.selectable = false;
			t.embedFonts = true;
			t.x = x;
			t.y = y;
			t.width = w;
			t.height = h;
			t.defaultTextFormat = formats[format];
			
			container.addChild(t);
			
			return t;
		}
		
	}

}