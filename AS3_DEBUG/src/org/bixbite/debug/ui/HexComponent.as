package org.bixbite.debug.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.framework.factories.GraphicsFactory;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class HexComponent extends Sprite
	{
		public var gFactory	:GraphicsFactory;
		public var w:Number = 100;
		public var h:Number = 100;
		
		public function HexComponent() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			gFactory = GraphicsFactory.getInstance();
			create();
			draw();
		}
		
		public function create():void 
		{
			
		}
		
		public function draw():void 
		{
			
		}
		
		public function setPosition(x:Number, y:Number):void 
		{
			this.x = x;
			this.y = y;
		}
		
		public function setSize(width:Number, height:Number):void 
		{
			this.w = width;
			this.h = height;
		}
		
	}

}