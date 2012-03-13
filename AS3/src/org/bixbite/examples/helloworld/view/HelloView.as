package org.bixbite.examples.helloworld.view 
{
	import flash.text.TextField;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.View;
	import org.bixbite.examples.helloworld.signal.HelloSignal;
	
	/**
	 * View is the display layer. By default will request some data. Then can only listen and react to the changes. 
	 * But it doesn't need to be aware where the changes coming from.
	 */
	public class HelloView extends View 
	{
		private var textField:TextField;
		
		public function HelloView() 
		{
			
		}
		
		override public function init():void 
		{
			textField = new TextField();
			textField.x = 100;
			textField.y = 100;
			
			stage.addChild(textField);
			
			addSlot("copyReplaced", onCopyReplaced);
			sendRequest("getCopyRequest", onCopy);
		}
		
		private function onCopyReplaced(s:HelloSignal):void 
		{
			applyCopy(s.copy);
		}
		
		private function onCopy(s:HelloSignal):void 
		{
			applyCopy(s.copy);
		}
		
		private function applyCopy(copy:String):void 
		{
			textField.text = copy;
		}
		
		
	}

}