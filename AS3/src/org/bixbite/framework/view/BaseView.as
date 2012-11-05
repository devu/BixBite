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
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.signal.StageSignal;
	
	/**
	 * This is abstract Class for Views, 2nd level of abstraction to encapsulate common set of methods
	 * It works with connection with DisplayListManager Module and StageManager
	 * @langversion 3.0
	 */
	public class BaseView extends View 
	{
		
		override public function init():void 
		{
			addSlot(DisplaySignal.CONTEXT_ADDED, onContextAdded);
			addSlot(DisplaySignal.CONTEXT_REMOVED, onContextRemoved);
		}
		
		private function onContextAdded(s:Signal):void 
		{
			addSlot(StageSignal.ON_RESIZE, onStageResize);
			contextAdded();
			draw();
		}
		
		private function onContextRemoved(s:Signal):void 
		{
			contextRemoved();
		}
		
		private function onStageResize(s:Signal):void 
		{
			resize();
			draw();
		}
		
		/*abstract*/ public function contextAdded():void { }
		/*abstract*/ public function contextRemoved():void { }
		/*abstract*/ public function resize():void { }
		/*abstract*/ public function draw():void { }
		
		public function setContext(name:String, context:DisplayObject, container:String = null):void
		{
			sendSignal(DisplaySignal.SET_CONTEXT, { name:name, context:context } );
			if (container) addContext(name, container);
		}
		
		public function addContext(name:String, container:String = "stage"):void
		{
			sendSignal(DisplaySignal.ADD_CONTEXT, { name:name, container:container} );
		}
		
		public function removeContext(name:String):void
		{
			sendSignal(DisplaySignal.REMOVE_CONTEXT, { name:name } );
		}
		
		override public function destroy():void 
		{
			removeSlot(StageSignal.ON_RESIZE);
			removeSlot(DisplaySignal.CONTEXT_ADDED);
			removeSlot(DisplaySignal.CONTEXT_REMOVED);
			removeSlot(DisplaySignal.CONTEXT_SET);
			
			super.destroy();
		}
		
	}
	
}