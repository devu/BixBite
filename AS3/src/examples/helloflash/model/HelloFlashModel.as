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

package examples.helloflash.model 
{
	import examples.helloflash.signal.BallSignal;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	
	/**
	 * @version  compatibility - 0.4.3
	 */
	public class HelloFlashModel extends Model 
	{
		
		private var ballSignal	:BallSignal;
		private var count		:int = 0;
		
		/**
         * In RL original example there is no Model of application provided. 
         * Bixbite It's a Model responsibility to describe environment that application live in. 
		 * Model is not only data provider! By definition modelling things, so it must specify some rules of the game.
         */
		public function HelloFlashModel() 
		{
			
		}
		
		override public function init():void
		{
			ballSignal = new BallSignal();
			attachSignal(ballSignal);
			
			addSlot(BallSignal.POKE, onPoke);
			
			count = 1;
			ballSignal.count = count;
			sendSignal(BallSignal.CREATE_BALL);
		}
		
		private function onPoke(s:ISignal):void 
		{
			count++;
			ballSignal.count = count;
			
			if ((count % 10) == 0){
				sendSignal(BallSignal.CREATE_BALL);
				sendSignal(BallSignal.RED_BALL);
			} else {
				sendSignal(BallSignal.CREATE_BALL);
				sendSignal(BallSignal.SHUFFLE);
			}
		}
	}
}