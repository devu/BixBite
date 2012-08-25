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
	import examples.helloworld.behaviour.Initialise;
	import examples.helloworld.data.HelloData;
	import examples.helloworld.transponder.HelloTransponder;
	import org.bixbite.core.Compound;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloWorld extends Compound 
	{
		public function HelloWorld() 
		{
			
		}
		
		override public function init():void 
		{
			register(HelloTransponder);
			register(HelloData);
			
			addBehaviour("HelloWorld.UPDATE_COPY", CopyHandler);
			addBehaviour("HelloWorld.INIT", Initialise);
			
			emitSignal("HelloWorld.INIT", { max:1000 } );
		}
		
	}

}