/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.view 
{
	import examples.helloworld.HelloWorld;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloView extends View 
	{
		private var textField	:TextField;
		private var context		:Sprite;
		
		public function HelloView() 
		{
			
		}
		
		override public function init():void 
		{
			context = new Sprite();
			
			textField = new TextField();
			textField.autoSize = "left";
			textField.selectable = false;
			
			context.x = 200 + Math.random() * 500;
			context.y = 50 + Math.random() * 600;
			
			context.addChild(textField);
			stage.addChild(context);
			
			addSlot("HelloWorld.SET_COPY", onSetCopy);
		}
		
		private function onSetCopy(s:Signal):void 
		{
			applyCopy(s.params.copy);
		}
		
		private function applyCopy(copy:String):void 
		{
			textField.htmlText = copy;
		}
	}

}