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

package examples.helloworld
{
	import examples.helloworld.behaviour.CopyHandler;
	import examples.helloworld.data.HelloData;
	import examples.helloworld.transponder.HelloTransponder;
	import examples.helloworld.view.HelloView;
	import org.bixbite.core.Compound;
	
	/**
	 * @version  compatibility - 0.5.0
	 * @since 0.4.2
	 * footprint 6.48kb.
	 * 
	 * Hello World Example, will show you simplicity and a basic flow within BixBite framework.
	 */
	public class MainHelloWorld extends Compound
	{
		/**
		 * Set your default triad.
		 */
		public function MainHelloWorld() 
		{
			var t:HelloTransponder 	= new HelloTransponder();
			var d:HelloData 		= new HelloData();
			var v:HelloView;
			
			for ( var i:int = 0; i < 20; i++){
				v = new HelloView();
				stageView.addView(v);
			}
			
			addBehaviour(HelloSignal.UPDATE_COPY, CopyHandler);
			
			startup(HelloSignal.INIT);
		}
		
	}
	
}