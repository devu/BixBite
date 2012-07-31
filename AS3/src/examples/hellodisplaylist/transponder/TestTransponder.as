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

package examples.hellodisplaylist.transponder 
{
	import examples.hellodisplaylist.HelloDisplayList;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @version  compatibility - 0.6.2
	 */
	public class TestTransponder extends Transponder 
	{
		private var mainView:Sprite;
		
		public function TestTransponder()
		{
			
		}
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onInputDown);
			addSensor(MouseEvent.MOUSE_UP, onInputUp);
		}
		
		private function onInputDown(e:MouseEvent):void 
		{
			// You can retrieve display object name if is interactive
			var name:String = getDisplayObjectName(e.target);
			
			
			
			// then perform some action
			switch(name)
			{
				case "subView":
					trace("subView");
					sendSignal(DisplaySignal.REMOVE_CONTEXT, { name:name } );
					break;
			}
			
			// As well as you can determine if the object under the clicked point is there
			// In this case it doesn't need to be interactive object, even shapes can play a role of buttons
			if (getDisplayObjectByName("mainView")){
				trace("mainView detected, so you can drag it");
				mainView = getDisplayObjectByName("mainView") as Sprite;
				mainView.startDrag();
			}
			
			if (getDisplayObjectByName("mainSubView")){
				trace("mainSubView detected");
				sendSignal(HelloDisplayList.CUSTOM_SIGNAL);
			}
		}
		
		private function onInputUp(e:MouseEvent):void 
		{
			if(mainView){
				mainView.stopDrag();
				mainView = null;
			}
		}
	}

}