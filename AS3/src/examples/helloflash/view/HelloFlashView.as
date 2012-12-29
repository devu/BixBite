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

package examples.helloflash.view 
{
	import examples.helloflash.HelloFlash;
	import examples.helloflash.view.context.HelloFlashOutput;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloFlashView extends View 
	{
		private var output:HelloFlashOutput;
		
		override public function init():void 
		{
			output = HelloFlashOutput(registerContext("HelloFlashOutput", HelloFlashOutput));
			output.x = 100;
			output.y = 100;
			addContext("HelloFlashOutput", "stage");
			
			addSlot(HelloFlash.CREATE_BALL, onCreateBall);
		}
		
		private function onCreateBall(s:Signal):void
		{
			output.text = "Click count:" + s.params;
		}
		
	}

}