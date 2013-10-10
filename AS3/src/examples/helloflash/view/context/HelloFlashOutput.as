/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.view.context 
{
	import flash.text.TextField;
	import org.bixbite.display.Context;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloFlashOutput extends Context 
	{
		private var tf:TextField;
		
		public function HelloFlashOutput() 
		{
			tf = new TextField();
			tf.selectable = false;
			tf.text = "Click count: 1";
			body.addChild(tf);
		}
		
		public function set text(value:String):void 
		{
			tf.text = value;
		}
		
	}

}