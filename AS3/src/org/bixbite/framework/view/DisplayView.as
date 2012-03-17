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
	 * Solution built upon Decoration pattern, to wrap up native Objects into MVC structure.
	 * Lets you control/expose selected aspects of your application or structure.
	 * 
	 * @langversion	3.0
	 * @version 0.2.9
	 */
	public class DisplayView extends View implements IDisplayView
	{
		private var _content		:DisplayObject;
		private var _parentView		:IDisplayViewContainer;
		private var _interactive	:Boolean;
		
		/**
		 * Constructor
		 * @param	content, optional injector allow you pass custom and already prepared component from subclass as a content attached to this View.
		 */
		public function DisplayView(content:DisplayObject = null) 
		{
			//Dependency Injection
			if (content) _content = content;
		}
		
		/**
		 * Initialise DisplayView with a default native DisplayObject (by default Shape);
		 */
		override public function init():void 
		{
			this.content = new Shape();
		}
		
		/**
		 * Parent view of this view
		 */
		public function get parentView():IDisplayViewContainer { return _parentView; }
		public function set parentView(value:IDisplayViewContainer):void { _parentView = value; }
		
		/**
		 * Native Flash DisplayObject attached to this view
		 */
		public function get content():DisplayObject { return _content; }
		public function set content(value:DisplayObject):void { _content = value; }
		
		public function get graphics():Graphics 
		{
			return _content["graphics"];
		}
		
		/**
		 * Interactivity flag let controllers determine set of actions to perform. 
		 * Unlike in native flash display list implementation there is no InteractiveObject equivalent. 
		 * And is not needed since any GUI logic is moved to controllers.
		 */
		public function get interactive():Boolean { return _interactive; }
		public function set interactive(value:Boolean):void { _interactive = value; }
	}

}