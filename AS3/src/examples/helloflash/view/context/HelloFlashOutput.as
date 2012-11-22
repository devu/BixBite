package examples.helloflash.view.context 
{
	import flash.text.TextField;
	import org.bixbite.framework.view.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class HelloFlashOutput extends Context 
	{
		private var textField:TextField;
		
		public function HelloFlashOutput() 
		{
			textField = new TextField();
			textField.selectable = false;
			textField.text = "Click count: 1";
			addChild(textField);
		}
		
		public function set text(value:String):void 
		{
			textField.text = value;
		}
		
	}

}