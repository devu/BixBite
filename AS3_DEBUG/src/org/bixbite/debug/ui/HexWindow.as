package org.bixbite.debug.ui 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.framework.factories.GraphicsFactory;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class HexWindow extends HexComponent 
	{
		private var color			:uint;
		private var titleCopy		:String;
		
		private var topCnt			:Sprite;
		private var bottomCnt		:Sprite;
		private var title			:HexLabel;
		private var half			:int = 50;
		private var ident			:int = 1;
		
		private var items			:Array;
		
		
		public function HexWindow(titleCopy:String, color:uint, x:Number = 0, y:Number = 0, ident:int = 1) 
		{
			this.titleCopy = titleCopy;
			this.color = color;
			this.ident = ident;
			
			setPosition(x, y);
		}
		
		override public function create():void 
		{
			items = [];
			
			topCnt		= new Sprite();
			topCnt.mouseEnabled = false;
			addChild(topCnt);
			
			title = new HexLabel(titleCopy, 0xFFFFFF, 12, 29, 94, 20);
			topCnt.addChild(title);
			
			bottomCnt 	= new Sprite();
			bottomCnt.y = half;
			bottomCnt.mouseEnabled = false;
			addChild(bottomCnt);
		}
		
		override public function draw():void 
		{
			gFactory.clear(topCnt.graphics);
			gFactory.drawTrapezoid(topCnt.graphics, 0, 0, 60, 120, half, color);
			
			gFactory.clear(graphics);
			gFactory.drawBox(graphics, 0, half, 120, bottomCnt.y-half, color);
			
			gFactory.clear(bottomCnt.graphics);
			gFactory.drawTrapezoid(bottomCnt.graphics, 0, 0, 120, 60, half, color);
		}
		
		public function duplicated():void
		{
			this.alpha = 0.5;
			gFactory.clear(topCnt.graphics);
			gFactory.drawTrapezoid(topCnt.graphics, 0, 0, 60, 120, half, color);
			gFactory.drawTrapezoid(topCnt.graphics, 2, 2, 56, 116, half, 0x666666);
		}
		
		public function addChildItem(item:DisplayObject, x:Number, y:Number, top:Boolean = true):void
		{
			item.x = x;
			item.y = y;
			
			if (top){
				topCnt.addChild(item);
			} else {
				bottomCnt.addChild(item);
			}
		}
		
		public function addListItem(item:DisplayObject):DisplayObject
		{
			items.push(item);
			item.y = bottomCnt.y;
			item.x = ident;
			addChild(item);
			
			//invalidate
			bottomCnt.y += item.height;
			draw();
			
			return item
		}
		
		
		
	}

}