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
	import org.bixbite.core.interfaces.IController;
	
	/**
     * <p><i>"The primary symptom of a controller is denial, that is I can’t see its symptoms in myself. — Keith Miller"</i></p>
     * <p>The Controller is an abstract class</p>
     * <p>Handles user input to change the state of the application, Interprets the mouse and keyboard inputs from the user, is mainly responsible for GUI logic, mediator between view and model, controls behaviour of the views and notify model with a signal system. 
	 * Following the rule "Keep Controllers skinny and Models fat". There is NO place in Controllers to handle business logic of the application due to original paradigm of MVC.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.4.1
     */
	public class Controller extends Actor implements IController 
	{
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function Controller() 
		{
			if (Object(this).constructor == Controller) throw new IllegalOperationError("Abstract Class");
			init();
		}
	}

}