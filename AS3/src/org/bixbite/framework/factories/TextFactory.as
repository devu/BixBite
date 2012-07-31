/**The MIT License

@copy (c) 2012 Devu Design Limited, Daniel Wasilewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package org.bixbite.framework.factories 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * @langversion	3.0
	 * @version 0.6.2
	 * @since 0.5.0
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