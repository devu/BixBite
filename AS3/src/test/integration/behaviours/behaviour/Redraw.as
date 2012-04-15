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

package test.integration.behaviours.behaviour 
{
	import flash.utils.getTimer;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	import test.integration.behaviours.data.MyData;
	import test.integration.behaviours.Signals;
	
	/**
	 * @version  compatibility - 0.5.2
	 * @since 0.5.0
	 */
	public class Redraw extends Behaviour
	{
		private var data	:MyData;
		private var phase	:int = 0;
		
		public function Redraw() 
		{
			
		}
		
		override public function init():void 
		{
			addResponder(Signals.TIME_DATA, onMyData, true);
		}
		
		private function onMyData(s:ISignal, data:MyData):void 
		{
			this.data = data;
		}
		
		override public function execute(s:ISignal):void
		{
			var dif:int = getTimer() - data.prevTime;
			data.prevTime = getTimer();
			
			var color:uint;
			if(phase % 2){
				if (dif <= 100){
					color = 0xFF0000;
				} else if (dif > 100 && dif < 200){
					color = 0x00FF00;
				} else {
					color = 0x0000FF;
				}
				responseTo(s.callerUID, Signals.CHANGE_COLOR, [color]);
			} else {
				color = 0x000000;
				sendSignal(Signals.CHANGE_COLOR, [color]);
				responseTo(s.callerUID, Signals.CHANGE_COLOR, [0xFF00FF]);
			}
			
			phase++;
		}
		
	}

}