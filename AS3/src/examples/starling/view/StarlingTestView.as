/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.starling.view 
{
	import examples.starling.view.context.StarlingContext;
	
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class StarlingTestView extends View 
	{
		private var context2D:Sprite;
		private var textField:TextField;
		
		override public function init():void 
		{
			context2D = Sprite(registerContext("context2D", StarlingContext));
			context2D.x = 100;
			context2D.y = 180;
			
			textField = new TextField(300, 22, "Hello Starling");
			textField.y = -40;
			context2D.addChild(textField);
			
			addSlot("contextDetected", onContextDetected);
			addSlot("contextNotDetected", onContextNotDetected);
			addSlot("destroyContext", onDestroyContext);
			
			addContext("context2D", "stage2D");
		}
		
		private function onDestroyContext(s:Signal):void 
		{
			removeContext("context2D");
		}
		
		override public function onContextAdded():void 
		{
			trace(this, "context has been added");
			trace(context2D.stage);
		}
		
		override public function onContextRemoved():void 
		{
			trace(this, "context has been removed");
			trace(context2D.stage);
		}
		
		private function onContextDetected(s:Signal):void 
		{
			textField.text = s.params.text;
		}
		
		private function onContextNotDetected(s:Signal):void 
		{
			textField.text = s.params.text;
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
	
}