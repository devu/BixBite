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

package examples.helloworld.view 
{
	import examples.helloworld.signal.HelloSignal;
	import flash.text.TextField;
	import org.bixbite.core.View;
	
	/**
	 * @version  compatibility - 0.4.4
	 * 
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
			textField.autoSize = "left";
			textField.selectable = false;
			textField.x = 100;
			textField.y = 100;
			
			system.stage.addChild(textField);
			
			addSlot("setCopy", onCopy);
			addSlot("copyReplaced", onCopyReplaced);
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
			textField.htmlText = copy;
		}
	}

}