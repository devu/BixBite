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
	
	/**
	 * @langversion	3.0
	 * @version 0.5.0
	 * @since 0.5.0
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