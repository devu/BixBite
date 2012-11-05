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

package org.bixbite.framework.transponder 
{
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.YTPlayer;
	
	/**
	 * @langversion	3.0
	 */
	public class YTPlayerTransponder extends Transponder 
	{
		override public function init():void 
		{
			addSlot(YTPlayer.INIT, onInit);
			addSlot(YTPlayer.PLAY, onPlay);
			addSlot(YTPlayer.PAUSE, onPause);
			addSlot(YTPlayer.STOP, onStop);
		}
		
		private function onInit(s:Signal):void 
		{
			sendSignal(YTPlayer.INIT, s.params);
		}
		
		private function onPlay(s:Signal):void 
		{
			sendSignal(YTPlayer.PLAY, s.params);
		}
		
		private function onPause(s:Signal):void
		{
			sendSignal(YTPlayer.STOP, s.params);
		}
		
		private function onStop(s:Signal):void
		{
			sendSignal(YTPlayer.STOP, s.params);
		}
		
		override public function destroy():void 
		{
			removeSlot(YTPlayer.INIT);
			removeSlot(YTPlayer.PLAY);
			removeSlot(YTPlayer.PAUSE);
			removeSlot(YTPlayer.STOP);
			
			super.destroy();
		}
		
	}

}