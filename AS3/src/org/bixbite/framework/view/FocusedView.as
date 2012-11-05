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

package org.bixbite.framework.view 
{
	import flash.display.DisplayObject;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.FocusSignal;
	
	/**
	 * @langversion	3.0
	 */
	public class FocusedView extends BaseView 
	{
		private var fContext:DisplayObject;
		
		override public function init():void 
		{
			super.init();
			
			addSlot(FocusSignal.SET_FOCUS, onSetFocus);
			addSlot(FocusSignal.FOCUS_IN, onFocusIn);
			addSlot(FocusSignal.FOCUS_LOST, onFocusLost);
		}
		
		private function onSetFocus(s:Signal):void
		{
			setFocus(s.params.status);
		}
		
		private function onFocusIn(s:Signal):void
		{
			focusIn();
		}
		
		private function onFocusLost(s:Signal):void
		{
			focusLost();
		}
		
		/*abstract*/ public function focusIn():void { }
		/*abstract*/ public function focusLost():void { }
		
		public function setFocus(state:Boolean = false):void 
		{
			if (!fContext) return;
			sendSignal(FocusSignal.SET_FOCUS, { state:state, displayObject:fContext } );
			(state) ? focusIn() : focusLost();
		}
		
		override public function setContext(name:String, context:DisplayObject, container:String = null):void 
		{
			fContext = context;
			super.setContext(name, context, container);
		}
		
		override public function removeContext(name:String):void 
		{
			fContext = null;
			super.removeContext(name);
		}
		
	}

}