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
	
	/**
	 * <p><i>"We view things not only from different sides, but with different eyes; we have no wish to find them alike. — Blaise Pascal"</i></p>
	 * 
	 * <p>The View manages the graphical and/or textual output of the application.</p>
	 * <p>Framework provides basic implementation of nested structure of the Views.
	 * Provides set of methods similar to the native Flash Display List and manages nested tree hierarchy. You can start with StageView, DisplayView or DisplayViewContainer as a ready to work building blocks.</p>
	 * <p>The View itself is just a subclass of Actor as any other member of MVC to provide Base Abstract class ready to extend and work with. We decided to keep it this way for future development purposes. 
	 * We planing to provide diferent versions of framework when main diference is based on how we dealing with View nested structure and its implementation. So the basic view is here to keep consistency across the Core of the Bixbite MVC.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.4.2
	 */
	public class View extends Actor implements IView
	{
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