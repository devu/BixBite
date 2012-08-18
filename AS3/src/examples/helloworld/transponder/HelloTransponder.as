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

package examples.helloworld.transponder 
{

	import examples.helloworld.HelloWorld;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	
	/**
	 * @langversion	3.0
	 * 
     * This Trasponder will detect if any text field has been clicked.
     * If so, will send signal demands to change the copy.
     * Trasponder don't care with text field. Although don't care witch and how Atom will resolve GET_COPY request.
     */
	public class HelloTransponder extends Transponder 
	{
		
		public function HelloTransponder() 
		{
			
		}
		
		/**
		 * Add system listener to capture user Input by adding sensors.
		 */
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			addSlot(HelloWorld.INIT, onInit);
			addSlot(HelloWorld.GET_DEFAULT_COPY, onGetDefaultCopy);
		}
		
		private function onInit(s:Signal):void
		{
			var max:int = s.params.max;
			responseToAll(HelloWorld.INIT, { max:max } );
		}
		
		private function onGetDefaultCopy(s:Signal):void 
		{
			sendSignal(HelloWorld.UPDATE_COPY, { isDefault:true } );
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			if (getDisplayObjectByType(TextField)) 
				sendSignal(HelloWorld.UPDATE_COPY, { isDefault:false } );
		}
		
	}

}