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
	import examples.helloworld.HelloSignal;
	import flash.display.Sprite;
	import flash.text.TextField;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.view.DisplayView;
	
	/**
	 * @version  compatibility - 0.5.0
	 * 
	 * View is the display layer. By default will request some data. Then can only listen and react to the changes. 
	 * But it doesn't need to be aware where the changes coming from.
	 */
	public class HelloView extends DisplayView 
	{
		private var textField:TextField;
		
		public function HelloView() 
		{
			
		}
		
		override public function init():void 
		{
			var container:Sprite = new Sprite();
			
			textField = new TextField();
			textField.autoSize = "left";
			textField.selectable = false;
			textField.x = 100;
			textField.y = 100;
			
			container.addChild(textField);
			
			setContext("myTextField", container);
			
			addSlot(HelloSignal.INIT			, onInit);
			addSlot(HelloSignal.SET_COPY		, onSetCopy);
		}
		
		private function onInit(s:ISignal):void
		{
			sendSignal(HelloSignal.GET_COPY);
		}
		
		private function onSetCopy(s:ISignal):void 
		{
			applyCopy(s.params[0]);
		}
		
		private function applyCopy(copy:String):void 
		{
			textField.htmlText = copy;
		}
	}

}