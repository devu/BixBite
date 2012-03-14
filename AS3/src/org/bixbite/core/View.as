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

package org.bixbite.core 
{
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.interfaces.IView;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p><i>"We view things not only from different sides, but with different eyes; we have no wish to find them alike. — Blaise Pascal"</i></p>
	 * 
	 * <p>The view manages the graphical and/or textual output of the application. 
	 * Views are designed to be nested and provides set of methods similar to the native Flash Display List to manage nested tree hierarchy.
	 * Bulding application hierarchy you need to start from TopView that serves as a root for all Views</p>
	 * 
	 * @langversion	3.0
	 * @version 0.3.1
	 */
	public class View extends Actor implements IView
	{
		/**
		 * Short local reference to the observer.
		 */
		private var _observer	:Observer 	= Observer.getInstance();
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function View() 
		{
			if (Object(this).constructor == View) throw new IllegalOperationError("Abstract Class");
			init();
 		}
	}

}