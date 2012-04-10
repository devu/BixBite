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

package examples.helloworld.behaviour 
{
	import examples.helloworld.data.HelloData;
	import examples.helloworld.HelloSignal;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	
	/**
	 * @version  compatibility - 0.5.0
	 */
	public class CopyHandler extends Behaviour 
	{
		private var copy:HelloData;
		
		public function CopyHandler() 
		{
			
		}
		
		override public function init():void 
		{
			sendRequest(HelloSignal.COPY_REQUEST, onCopyData);
		}
		
		private function onCopyData(data:HelloData):void 
		{
			copy = data;
		}
		
		override public function execute(s:ISignal):void 
		{
			var copyString:String;
			switch(s.params[0])
			{
				case "english":
					copyString = copy.english;
					break;
				case "polish":
					copyString = copy.polish;
					break;
				case "french":
					copyString = copy.french;
					break;
				case "german":
					copyString = copy.german;
					break;
			}
			
			sendSignal(HelloSignal.SET_COPY, [copyString]);
		}
		
	}

}