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

package examples.starling.transponder 
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class StarlingTransponder extends Transponder 
	{
		private var context:IContext;
		private var miss:int = 0;
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/**
		 * This is a little demonstration how you can utilise Transponder as a UI logic handler to controll View states
		 * @param	e native event
		 */
		private function onMouseDown(e:Event):void 
		{
			var context:IContext = getContextById("context2D", "stage2D");
			
			if (context) {
				responseTo(context.parrentView.uid, "contextDetected", { text:context.id } );
				miss = 0;
			} else {
				miss++;
				if(miss<3)
					responseToAll("contextNotDetected", { text:"There is no Interactive Context" } );
				else
					responseToAll("destroyContext");
			}
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
	
}