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

package org.bixbite.examples.helloworld
{
	import org.bixbite.core.Application;
	import org.bixbite.examples.helloworld.controller.HelloController;
	import org.bixbite.examples.helloworld.model.HelloModel;
	import org.bixbite.examples.helloworld.view.HelloView;
	
	/**
	 * @version  compatibility - 0.4.0
	 * Hello World Example, will show you simplicity and a basic flow within Bixbite MVC.
	 * This example not even using framework but just a Core. Core is fully functioning stand alone unit ready to build framework on top of it. 
	 * But still in many situations you can rely on Core functionality only to achive simple tasks.
	 * The simplest way would be to have just view and model as an copy provider to realise this task. But let's to be conservative and show whole triad.
	 */
	public class MainHelloWorld extends Application
	{
		/**
		 * Set your default triad.
		 */
		public function MainHelloWorld():void 
		{
			var c:HelloController = new HelloController();
			var m:HelloModel = new HelloModel();
			var v:HelloView = new HelloView();
		}
		
	}
	
}