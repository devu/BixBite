/**The MIT License

@copy (c) 2012 Devu Design Limited, Daniel Wasilewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
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