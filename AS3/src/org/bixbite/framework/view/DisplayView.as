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
	import flash.display.Graphics;
	import flash.display.Shape;
	import org.bixbite.core.View;
	import org.bixbite.framework.interfaces.IDisplayView;
	import org.bixbite.framework.interfaces.IDisplayViewContainer;
	
	/**
	 * DisplayView, part of Composite pattern of the display list. 
	 * The basic View extention to work with flash native DisplayObject.
	 * Solution built upon Decoration pattern, to wrap up native Objects into BixBite structure.
	 * Lets you control/expose selected aspects of your application or structure.
	 * 
	 * @langversion	3.0
	 * @version 0.5.0
	 */
	public class DisplayView extends View implements IDisplayView
	{
		private var _context		:DisplayObject;
		private var _parentView		:IDisplayViewContainer;
		private var _interactive	:Boolean;
		
		/**
		 * Constructor
		 * @param	content, optional injector allow you pass custom and already prepared component from subclass as a content attached to this View.
		 */
		public function DisplayView() 
		{
			
		}
		
		/**
		 * 
		 * @param	name
		 * @param	object
		 */
		public function setContext(name:String, object:DisplayObject):void
		{
			_context = object;
			_context.name = name + uid;
		}
		
		/**
		 * Initialise DisplayView with a default native DisplayObject (by default Shape);
		 */
		override public function init():void 
		{
			this.context = new Shape();
		}
		
		/**
		 * Parent view of this view
		 */
		public function get parentView():IDisplayViewContainer { return _parentView; }
		public function set parentView(value:IDisplayViewContainer):void { _parentView = value; }
		
		/**
		 * Native Flash DisplayObject attached to this view
		 */
		public function get context():DisplayObject { return _context; }
		public function set context(value:DisplayObject):void { _context = value; }
	}

}