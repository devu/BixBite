package org.bixbite.framework.data.vo 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ContextItem extends Sprite 
	{
		private var _content:DisplayObject;
		
		public function ContextItem() 
		{
			this.mouseEnabled = false;
		}
		
		public function get content():DisplayObject 
		{
			return _content;
		}
		
		public function set content(child:DisplayObject):void 
		{
			addChild(_content = child);
		}
	}

}