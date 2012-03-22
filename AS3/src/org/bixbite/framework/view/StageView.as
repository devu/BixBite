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
	import flash.display.Sprite;
	
	/**
	 * StageView, is a classic implementation of main MVC paradigm, when views can be nested and they need a root or 'Top View' class to start from.
	 * This class serve this purpose. It is also part of Composite pattern and directly extends DisplayViewContainer as the highest in display list hierarchy. 
	 * In fact the only diference between StageView and DisplayViewContainer is where content is added during Actor initialistion.
	 * 
	 * @langversion	3.0
	 * @version 0.4.3
	 */
	public class StageView extends DisplayViewContainer 
	{
		
		/**
		 * Constructor
		 */
		public function StageView() 
		{
			
		}
		
		/**
		 * Overrides actor abstract method and place content directly on native stage of the Flash Player.
		 */
		override public function init():void 
		{
			context = new Sprite()
			system.stage.addChild(context);
		}
		
	}

}