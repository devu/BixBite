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

package examples.helloworld.data
{
	import examples.helloworld.HelloWorld;
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	
	/**
	 * @version  compatibility - 0.6.1
	 * 
	 * This Data component is a copy holder that will reponse to Compound on reqest being sent from Behaviour data.
	 * Data component don't care who is calling, will respond as soon as a signal has been recieved.
	 *
	 * The main purpose od the Data component is to react on specific signal from Behaviour and response with Data set that provides.
	 */
	public class HelloData extends Data
	{
		public var english	:String = "<font color='#000000'> Hello world </font>";
		public var polish	:String = "<font color='#000000'> Witaj świecie </font>";
		public var french	:String = "<font color='#000000'> Bonjour tout le monde </font>";
		public var german	:String = "<font color='#000000'> Hallo Welt </font>";
		
		public function HelloData()
		{
		
		}
		
		override public function init():void
		{
			addSlot(HelloWorld.COPY_REQUEST, onCopyRequest);
		}
		
		private function onCopyRequest(s:Signal):void
		{
			responseTo(s.callerUID, HelloWorld.COPY_REQUEST);
		}
		
		override public function destroy():void 
		{
			removeSlot(HelloWorld.COPY_REQUEST);
			
			super.destroy();
		}
	
	}

}