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

package examples.imagegallery.view 
{
	import flash.display.DisplayObject;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.AssetSignal;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @version  compatibility - 0.6.2
	 */
	public class BaseView extends View 
	{
		private var setContextSRS		:Function;
		private var addContextSRS		:Function;
		private var removeContextSRS	:Function;
		private var loadContextSRS		:Function;
		
		public function BaseView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(DisplaySignal.CONTEXT_SET		, onContextSet);
			addSlot(DisplaySignal.CONTEXT_ADDED		, onContextAdded);
			addSlot(DisplaySignal.CONTEXT_REMOVED	, onContextRemoved);
			addSlot(AssetSignal.CONTEXT_LOADED		, onContextLoaded);
			
			setContextSRS 		= getSlotReference(DisplaySignal.SET_CONTEXT)[0];
			addContextSRS 		= getSlotReference(DisplaySignal.ADD_CONTEXT)[0];
			removeContextSRS 	= getSlotReference(DisplaySignal.REMOVE_CONTEXT)[0];
			loadContextSRS 		= getSlotReference(AssetSignal.LOAD_CONTEXT)[0];
		}
		
		/**
		 * Create context of this view and register it within DisplayListManager module
		 * You can create multiple contexts per view.
		 * @param	name
		 * @param	context
		 */
		public function setContext(name:String, context:DisplayObject):void
		{
			// SRS
			signal.params = { name:name, context:context };
			setContextSRS(signal);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	container
		 */
		public function addContext(name:String, container:String):void
		{
			// SRS
			signal.params = { name:name, container:container };
			addContextSRS(signal);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	container
		 */
		public function removeContext(name:String):void
		{
			// SRS
			signal.params = { name:name };
			removeContextSRS(signal);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	path
		 */
		public function loadContext(name:String, path:String, async:Boolean = false):void
		{
			// SRS
			signal.params = { name:name, path:path, async:async };
			loadContextSRS(signal);
		}
		
		/**
		 * Internal abstract methods
		 * @param	s
		 */
		internal function onContextSet(s:Signal):void { }
		internal function onContextAdded(s:Signal):void { }
		internal function onContextRemoved(s:Signal):void { }
		internal function onContextLoaded(s:Signal):void { }
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			setContextSRS 		= null;
			addContextSRS 		= null;
			removeContextSRS 	= null;
			loadContextSRS 		= null;
			
			super.destroy();
		}
	}
}