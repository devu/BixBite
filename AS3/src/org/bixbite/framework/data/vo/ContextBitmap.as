package org.bixbite.framework.data.vo 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ContextBitmap extends ContextItem 
	{
		public var bitmap:Bitmap;
		
		public function ContextBitmap() 
		{
			
		}
		
		override public function set content(child:DisplayObject):void 
		{
			bitmap = child as Bitmap
			bitmap.smoothing = true;
			
			super.content = child;
		}
		
		public function clone():Bitmap
		{
			return new Bitmap(bitmap.bitmapData, "auto", true);
		}
		
	}

}