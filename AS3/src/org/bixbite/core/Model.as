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
	import org.bixbite.core.Actor;
	import org.bixbite.core.interfaces.IModel;
	
	/**
     * <p><i>"According to the standard model billions of years ago some little quantum fluctuation, perhaps a slightly
     * lower density of matter, maybe right where we’re sitting right now, caused our galaxy to start collapsing around here.
     * — Seth Lloyd"</i></p>
     *
     * <p>The Model contains the 'application data' AND 'business logic' to manage the STATE of the application. 
	 * Same way as you can't control laws of physics, you shouldn't try to put this responsibility into controllers. 
	 * You can control many objects that are under the defined laws of physics, but is the Model that defines them not Controller.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.3.1
     */
	public class Model extends Actor implements IModel
	{
		private var _observer:Observer = Observer.getInstance();
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function Model() 
		{
			if (Object(this).constructor == Model) throw new IllegalOperationError("Abstract Class");
			init();
		}
	}

}