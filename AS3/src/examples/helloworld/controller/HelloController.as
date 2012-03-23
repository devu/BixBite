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

package examples.helloworld.controller 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.bixbite.core.Controller;
	
	/**
	 * @version  compatibility - 0.4.4
	 * 
     * This Controller will detect if your text field has been clicked.
     * If so, will send signal demands to change the copy.
     * Controller don't care with text field. Although don't care witch and how Model will resolve replaceCopy request.
     * It can be any or many of them at the same time.
     */
	public class HelloController extends Controller 
	{
		
		public function HelloController() 
		{
			
		}
		
		/**
		 * Add system listener to capture user Input.
		 */
		override public function init():void 
		{
			system.addListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var objects:Array = system.getObjects();
			
			var tf:TextField;
			for each(var o:Object in objects){
				if (o is TextField) {
					tf = o as TextField;
					tf.mouseEnabled = false;
					sendSignal("replaceCopy");
				}
			}
		}
		
	}

}