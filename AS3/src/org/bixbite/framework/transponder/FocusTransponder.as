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

package org.bixbite.framework.transponder 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.FocusSignal;
	import org.bixbite.utils.ClassUtil;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class FocusTransponder extends Transponder 
	{
		private var objects:Array = [];
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			addSlot(FocusSignal.SET_FOCUS, onSetFocus);
		}
		
		private function onSetFocus(s:Signal):void 
		{
			var o:DisplayObject = s.params.displayObject;
			var index:int = objects.indexOf(o);
			
			if(s.params.state){
				if (index == -1) objects.push(o);
			} else {
				objects.splice(index, 1);
			}
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var selected	:Array = [];
			var uid			:String;
			var index		:int;
			var o			:DisplayObject;
			
			for each(o in getDisplayObjects()) {
				index = objects.indexOf(o);
				
				if (index == -1) {
					uid = ClassUtil.retrieveUID(o);
					responseTo(uid, FocusSignal.FOCUS_IN);
					selected.push(o);
				} else {
					selected.push(objects.splice(index, 1)[0]);
				}
			}
			
			for each(o in objects) {
				uid = ClassUtil.retrieveUID(o);
				responseTo(uid, FocusSignal.FOCUS_LOST);
			}
			
			objects = selected;
		}
		
	}

}