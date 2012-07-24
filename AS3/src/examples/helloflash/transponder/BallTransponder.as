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

package examples.helloflash.transponder 
{
	import examples.helloflash.HelloFlash;
	import flash.events.MouseEvent;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	
	/**
	 * @version  compatibility - 0.6.1
	 */
	public class BallTransponder extends Transponder 
	{
		public function BallTransponder()
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			if (findObjectByName("ball")) {
				// One to many on view channel
				//response(Signals.DIRECT_RESPONSE);
				
				//One to One on view channel
				//responseTo(e.target, HelloFlash.DIRECT_RESPONSE);
				
				//One to Many on Compound channel
				sendSignal(HelloFlash.POKE);
			}
		}
		
	}

}