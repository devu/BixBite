/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.view.context 
{
	import flash.text.TextField;
	import org.bixbite.core.Context;
	
	/**
	 * @langversion	3.0
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