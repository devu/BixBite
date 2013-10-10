package examples.helloworld.view.context 
{
	import flash.text.TextField;
	import org.bixbite.display.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TextContext extends Context 
	{
		private var tf:TextField;
		
		public function TextContext() 
		{
			tf = new TextField();
			tf.autoSize = "left";
			tf.selectable = false;
			init();
		}
		
		override public function init():void 
		{
			body.addChild(tf);
		}
		
		public function setText(text:String):void 
		{
			tf.text = text;
		}
		
		public function setHTMLText(text:String):void 
		{
			tf.htmlText = text;
		}
		
	}

}