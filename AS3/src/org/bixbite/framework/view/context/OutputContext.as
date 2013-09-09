package org.bixbite.framework.view.context 
{
	import flash.text.TextField;
	import org.bixbite.framework.view.Context2D;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class OutputContext extends Context2D 
	{
		private var txt:TextField;
		
		public function OutputContext() 
		{
			mouseEnabled = false;
			
			txt = new TextField(); 
			txt.autoSize = "left";
			addChild(txt);
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