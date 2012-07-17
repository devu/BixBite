package org.bixbite.debug.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.framework.factories.GraphicsFactory;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class HexListItem extends HexComponent 
	{
		private var titleLabel	:HexLabel;
		private var countLabel	:HexLabel;
		private var titleCopy	:String;
		
		private var itemW		:Number;
		private var itemH		:Number;
		private var ident		:Number;
		
		public function HexListItem(title:String = "Label", ident:Number = 1, x:Number = 0, y:Number = 0, w:Number = 118, h:Number = 20) 
		{
			this.titleCopy = title;
			this.ident = ident;
			this.mouseEnabled = false;
			
			setPosition(x, y);
			setSize(w, h);
		}
		
		override public function create():void
		{
			titleLabel = new HexLabel(titleCopy, 0xFFFFFF, 26, 1, w - 28, h - 2);
			addChild(titleLabel);
			countLabel = new HexLabel("0", 0xFFFFFF, 2, 1, 24, h - 2);
			addChild(countLabel);
		}
		
		override public function draw():void 
		{
			gFactory.clear(this.graphics);
			gFactory.drawBox(this.graphics, 0, 0, w, h, 0x666666);
			gFactory.drawBox(this.graphics, ident, ident, w - ident, h - ident, 0xEEEEEE);
			gFactory.drawBox(this.graphics, ident, ident, w -(ident * 2), h - (ident * 2), 0x999999);
		}
		
		public function set counter(value:int):void
		{
			titleLabel.textColor = 0xFF0000;
			countLabel.text = value.toString();
		}
		
	}

}