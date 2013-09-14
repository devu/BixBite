package org.bixbite.framework.view.context 
{
	import flash.text.TextField;
	import org.bixbite.framework.view.context.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class OutputContext extends Context
	{
		private var txt:TextField;
		
		override public function init():void 
		{
			mouseEnabled = false;
			txt = new TextField(); 
			txt.autoSize = "left";
			addChild(txt);
		}
		
		override public function draw():void
		{
			
		}
		
		public function set text(value:String):void 
		{
			txt.text = value;
		}
		
		public function appendText(value:String):void 
		{
			txt.appendText(value);
		}
		
	}

}