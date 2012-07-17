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
	import flash.display.Graphics;
	
	/**
	 * @version 0.5.5
	 * @since 0.5.5
	 */
	public class GraphicsFactory
	{
		private static var _instance:GraphicsFactory = new GraphicsFactory();
		
		private var hexCmd:Vector.<int>;
		private var tpzCmd:Vector.<int>;
		
		public function GraphicsFactory() 
		{
			hexCmd = new <int>[1, 2, 2, 2, 2, 2, 2];
			hexCmd.fixed = true;
			
			tpzCmd = new <int>[1, 2, 2, 2];
			tpzCmd.fixed = true;
		}
		
		public static function getInstance():GraphicsFactory
		{
			return _instance
		}
		
		public function drawHex(g:Graphics):void
		{
			
		}
		
		public function drawTrapezoid(g:Graphics, x:Number, y:Number, topWidth:Number, bottomWidth:Number, height:Number, color:uint = 0x00000, alpha:Number = 1):void
		{
			var dif:Number;
			var tl:Number;
			var tr:Number;
			var bl:Number;
			var br:Number;
			
			if (topWidth < bottomWidth){
				dif = (bottomWidth - topWidth) * 0.5;
				tl = dif + x;
				tr = bottomWidth - dif + x;
				bl = x;
				br = bottomWidth + x;
			} else {
				dif = (topWidth - bottomWidth) * 0.5;
				tl = x;
				tr = topWidth;
				bl = dif;
				br = topWidth - dif;
			}
			
			var data:Vector.<Number> = new <Number>[tl,y, tr,y, br,height, bl,height];
			
			g.beginFill(color, alpha);
			g.drawPath(tpzCmd, data);
		}
		
		public function drawBox(g:Graphics, x:Number, y:Number, width:Number, height:Number, color:uint = 0x000000, alpha:Number = 1):void
		{
			g.beginFill(color, alpha);
			g.drawRect(x, y, width, height);
		}
		
		public function clear(g:Graphics):void 
		{
			g.clear();
		}
		
	}

}