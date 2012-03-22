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

package examples.helloworld.model
{
	import examples.helloworld.signal.HelloSignal;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	
	/**
	 * @version  compatibility - 0.4.3
	 * 
	 * This model is a copy holder that will reponse on 2 diferent signals.
	 * Model don't care who is calling, will respond as soon as a signal has been recieved.
	 * Althoght don't need to know wich view will display this infromation.
	 *
	 * The main purpose od the Model is to react on specific set of signals, perform business logic acordingly to set of rulles and broadcast signals in response.
	 */
	public class HelloModel extends Model
	{
		private var helloSignal:HelloSignal;
		
		public function HelloModel()
		{
		
		}
		
		override public function init():void
		{
			helloSignal = new HelloSignal();
			helloSignal.copy = "<font color='#000000'> Hello World </font>";
			attachSignal(helloSignal);
			
			addSlot("replaceCopy", onReplaceCopy);
			sendSignal("setCopy");
		}
		
		private function onReplaceCopy(s:ISignal):void
		{
			helloSignal.copy = "<font color='#FF0000'> Hello Bixbite </font>";
			sendSignal("copyReplaced");
		}
	
	}

}