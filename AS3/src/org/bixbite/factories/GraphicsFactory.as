/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.factories 
{
	import flash.display.Graphics;
	
	/**
	 * @langversion	3.0
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