package org.bixbite.display 
{
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class GraphicsLib 
	{
		public var ref:*;
		
		public function GraphicsLib(ref:*) 
		{
			this.ref = ref;
		}
		
		public function alpha(value:Number):void 
		{
			ref.alpha = value;
		}
		
		public function clear():void 
		{
			ref.graphics.clear();
		}
		
		public function beginFill(color:uint, alpha:Number):void 
		{
			ref.graphics.beginFill(color, alpha);
		}
		
		public function drawRect(x:Number, y:Number, w:Number, h:Number):void 
		{
			ref.graphics.drawRect(x, y, w, h);
		}
		
		public function drawCircle(x:Number, y:Number, r:int):void 
		{
			ref.graphics.drawCircle(x, y, r);
		}
		
		public function rotate(angle:Number):void 
		{
			ref.rotation = angle;
		}
		
		public function move(x:Number, y:Number):void 
		{
			ref.x = x;
			ref.y = y;
		}
	}

}