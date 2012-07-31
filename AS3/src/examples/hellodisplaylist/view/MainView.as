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
	 * @version  compatibility - 0.6.2
	 */
	public class MainView extends View 
	{
		private var context:Sprite;
		private var subcontext:Sprite;
		
		public function MainView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(DisplaySignal.CONTEXT_SET		, onContextSet);
			addSlot(DisplaySignal.CONTEXT_ADDED		, onContextAdded);
			addSlot(DisplaySignal.CONTEXT_REMOVED	, onContextRemoved);
			
			createContext();
		}
		
		private function createContext():void 
		{
			// 1. Baisc example
			// create main context of this view
			context = new Sprite();
			// register it
			sendSignal(DisplaySignal.SET_CONTEXT, { name:"mainView", context:context } );
			// add to display list
			sendSignal(DisplaySignal.ADD_CONTEXT, { name:"mainView", container:"stage" } );
			
			// 2. Multiple context of this same View
			// create another display object
			subcontext = new Sprite();
			// register it withing display list in order to access it from this or any other view
			sendSignal(DisplaySignal.SET_CONTEXT, { name:"mainSubView", context:subcontext } );
			// add to some display list container, in this case is internal mainView registered above
			sendSignal(DisplaySignal.ADD_CONTEXT, { name:"mainSubView", container:"mainView" } );
			
			// However if you are inside one view is perfectly fine and even recomended to do this standard way
			// as long as you don't need to recive DisplaySignal.CONTEXT_ADDED signal
			
			// context.addChild(subcontext);
		}
		
		private function onContextSet(s:Signal):void
		{
			trace("context of", this, "has been set with a name", s.params.name, "and unique id:", s.params.contextUID );
			
			// you can do some stuff here even before object is added into display list
			switch(s.params.name)
			{
				case "mainView":
					context.x = 100;
					context.y = 100;
					break;
				case "mainSubView":
					subcontext.x = 10;
					subcontext.y = 10;
					break;
			}
		}
		
		private function onContextAdded(s:Signal):void 
		{
			trace("context of", this, "has been added to", s.params.container);
			
			switch(s.params.name)
			{
				case "mainView":
					context.mouseEnabled = false;
					context.graphics.beginFill(0x880000);
					context.graphics.drawRect(0, 0, 100, 100);
					break;
				case "mainSubView":
					subcontext.mouseEnabled = false;
					subcontext.graphics.beginFill(0x006600);
					subcontext.graphics.drawRect(0, 0, 80, 80);
					break;
			}
		}
		
		private function onContextRemoved(s:Signal):void 
		{
			trace("context of", this, "has been removed from", s.params.container);
		}
		
	}

}