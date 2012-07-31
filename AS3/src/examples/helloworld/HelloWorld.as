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
	import examples.helloworld.view.RootView;
	import org.bixbite.core.Compound;
	
	/**
	 * @version  compatibility - 0.6.2
	 */
	public class HelloWorld extends Compound 
	{
		public static const INIT				:String = "HelloWorld.INIT";
		public static const COPY_REQUEST		:String = "HelloWorld.COPY_REQUEST";
		public static const UPDATE_COPY			:String = "HelloWorld.UPDATE_COPY";
		public static const GET_DEFAULT_COPY	:String = "HelloWorld.GET_DEFAULT_COPY";
		public static const SET_COPY			:String = "HelloWorld.SET_COPY";
		
		public function HelloWorld() 
		{
			
		}
		
		override public function init():void 
		{
			register(HelloTransponder);
			register(HelloData);
			register(RootView);
			
			addBehaviour(HelloWorld.UPDATE_COPY, CopyHandler);
			
			sendSignal(HelloWorld.INIT, { max:20 } );
		}
		
	}

}