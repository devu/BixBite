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

package examples.hellodisplaylist.view 
{
	import flash.display.Sprite;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @langversion	3.0
	 */
	public class SubView extends View 
	{
		private var context				:Sprite;
		
		public function SubView() 
		{
			
		}
		
		override public function init():void 
		{
			// Yes you right, this is not display object, however stage is available even here
			trace(stage);
			
			addSlot(DisplaySignal.CONTEXT_SET		, onContextSet);
			addSlot(DisplaySignal.CONTEXT_ADDED		, onContextAdded);
			addSlot(DisplaySignal.CONTEXT_REMOVED	, onContextRemoved);
			
			// create
			context = new Sprite();
			// register it
			sendSignal(DisplaySignal.SET_CONTEXT, { name:"subView", context:context } );
			// add
			sendSignal(DisplaySignal.ADD_CONTEXT, { name:"subView", container:"mainView" } );
		}
		
		private function onContextSet(s:Signal):void
		{
			trace("context of", this, "has been set with a name", s.params.name, "and unique id:", s.params.contextUID );
			
			context.x = 110;
			context.y = 20;
			
			// Yes you right, context is not on the stage, however is available even here
			trace(stage);
		}
		
		private function onContextAdded(s:Signal):void 
		{
			trace("context of", this, "has been added to", s.params.container);
			
			context.graphics.beginFill(0x000066);
			context.graphics.drawRect(0, 0, 60, 60);
		}
		
		private function onContextRemoved(s:Signal):void
		{
			trace("context of", this, "has been removed");
			
			context.graphics.clear();
		}
		
		override public function destroy():void 
		{
			//Because unregister has been invoked, destroy method will be triggered
			
			removeSlot(DisplaySignal.CONTEXT_SET);
			removeSlot(DisplaySignal.CONTEXT_ADDED);
			removeSlot(DisplaySignal.CONTEXT_REMOVED);
			
			sendSignal(DisplaySignal.REMOVE_CONTEXT, { name:"subView" } );
			while (context.numChildren > 0) context.removeChildAt(0);
			context.graphics.clear();
			context = null;
			
			super.destroy();
		}
		
	}

}