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

package examples.helloflash.controller 
{
	import examples.helloflash.signal.BallSignal;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import org.bixbite.core.Controller;
	
	/**
	 * @version  compatibility - 0.4.2
	 */
	public class BallController extends Controller 
	{
		public function BallController()
		{
			
		}
		
		override public function init():void 
		{
			system.addListener(MouseEvent.CLICK, onMouseClick);
		}
		
		/**
		 * Controller, captures user input and perform GUI logic.
		 * Find out if any ball has been clicked, then broadcast signal.
		 * @param	e native event listener.
		 */
		private function onMouseClick(e:MouseEvent):void 
		{
			var balls:Array = system.getObjects();
			for each(var b:DisplayObject in balls){
				if (b.name == "ball") sendSignal(BallSignal.POKE);
				return;
			}
		}
		
	}

}