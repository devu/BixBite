package org.bixbite.debug.ui 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import org.bixbite.framework.factories.TextFactory;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class HexLabel extends HexComponent 
	{
		private var textFactory	:TextFactory;
		private var label		:TextField;
		
		private var copy		:String;
		private var color		:uint;
		
		public function HexLabel(copy:String, color:uint = 0xFFFFFF, x:Number = 0, y:Number = 0, w:Number = 100, h:Number = 100) 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			this.copy 		= copy;
			this.color 		= color;
			
			setPosition(x, y);
			setSize(w, h);
		}
		
		override public function create():void 
		{
			textFactory 	= TextFactory.getInstance();
			
			label = textFactory.createEmbededText(this, "hexLabel", 0, 0, w, h, color);
			label.mouseEnabled = false;
			label.text = copy;
		}
		
		public function get text():String
		{
			return label.text;
		}
		
		public function set text(copy:String):void
		{
			label.text = copy;
		}
		
		public function set textColor(value:uint):void
		{
			label.textColor = value;
		}
		
	}

}