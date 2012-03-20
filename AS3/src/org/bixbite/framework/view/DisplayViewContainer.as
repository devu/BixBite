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
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.bixbite.framework.interfaces.IDisplayView;
	import org.bixbite.framework.interfaces.IDisplayViewContainer;
	
	/**
	 * DisplayViewContainer, the most important class in Composition pattern in order to manipulate display list and create nested structures.
	 * Provides set of methods to handle children DisplayView of every DisplayObjectContainer.
	 * 
	 * @langversion	3.0
	 * @version 0.4.1
	 */
	public class DisplayViewContainer extends DisplayView implements IDisplayViewContainer
	{
		/**
		 * Array of views as a children of this view
		 */
		private var children	:Array = [];
		
		/**
		 * Constructor
		 * @param	content, optional injector allow you pass custom and already prepared component from subclass as a content attached to this View.
		 */
		public function DisplayViewContainer(context:DisplayObjectContainer = null) 
		{
			super(context);
		}
		
		/**
		 * Initialise DisplayView with a default native DisplayObjectContainer (by default Sprite);
		 */
		override public function init():void 
		{
			context = new Sprite();
		}
		
		/**
		 * Add child to this view
		 * @param	view, child view reference
		 * @param	addContent, flag to add child view's content automatically into native display list
		 * @return 	child view added to this view
		 */
		public function addView(view:IDisplayView):IDisplayView
		{
			view.parentView = this;
			addViewContent(view);
			children[children.length] = view;
			return view
		}
		
		/**
		 * Add child to this view at specific index of children array
		 * @param	id, index of a child
		 * @param	view, child view reference
		 * @param	addContent, flag to add child view's content automatically into native display list
		 * @return 	child view added to this view
		 */
		public function addViewAt(id:int, view:IDisplayView):IDisplayView
		{
			view.parentView = this;
			addViewContent(view);
			children.splice(id, 0, view);
			return view
		}
		
		/**
		 * This private method will automatically add any Flash native displayable content into added DisplayView.
		 * @param	view
		 */
		private function addViewContent(view:IDisplayView):void
		{
			if (context && view.context) addChild(view.context);
		}
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			return DisplayObjectContainer(context).addChild(child);
		}
		
		/**
		 * Remove child view base on reference
		 * @param	view, reference to child view to be removed
		 * @return 	reference to removed view
		 */
		public function removeView(view:IDisplayView):IDisplayView
		{
			return removeViewAt(children.indexOf(view.uid));
		}
		
		/**
		 * Remove child view base on index
		 * @param	id index of children array
		 * @return 	reference to removed view
		 */
		public function removeViewAt(id:int):IDisplayView
		{
			var view:IDisplayView = children[id];
			children.splice(id, 1);
			DisplayObjectContainer(context).removeChild(view.context);
			return view
		}
		
		/**
		 * Remove range of children views from current view
		 * @param	from start index
		 * @param	howMany number of elelemnts to remove counting from start index
		 * @return 	array of references to already removed views
		 */
		public function removeViewsAt(from:int, howMany:int):Array
		{
			var a:Array = children.splice(from, howMany);
			for each(var view:IDisplayView in a) DisplayObjectContainer(context).removeChild(view.context);
			return a
		}
		
		/**
		 * Remove all children views from current view
		 * @return 	array of references to already removed views
		 */
		public function removeAllViews():Array
		{
			return removeViewsAt(0, children.length);
		}
		
		/**
		 * Number of children views of this view
		 */
		public function get numViews():int { return children.length; }
		
	}

}