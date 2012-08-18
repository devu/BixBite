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

package org.bixbite.framework.behaviour
{
	import flash.events.Event;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.YTPlayer;
	
	/**
	 * @langversion	3.0
	 */
	public class YTPlayerStatus extends YTPlayerInit
	{
		private static const STATE_READY	:int = -1;
		private static const STATE_ENDED	:int = 0;
		private static const STATE_PLAYING	:int = 1;
		private static const STATE_PAUSED	:int = 2;
		private static const STATE_CUED		:int = 5;
		
		private var isPlaying:Boolean = false;
		
		public function YTPlayerStatus()
		{
		
		}
		
		override public function setup():void 
		{
			data.player.addEventListener("onStateChange", onPlayerStateChange);
		}
		
		private function onPlayerStateChange(e:Event):void
		{
			var state:int = Object(e).data;
			
			switch (state)
			{
				case STATE_READY:
					trace("YTPlayer::STATE_READY");
					isPlaying = false;
					
					sendSignal(YTPlayer.PLAYER_READY, { player:e.target } );
					if (data.autoPlay && data.videoId){
						data.play();
					}
					break;
					
				case STATE_ENDED: 
					trace("YTVideo::STATE_ENDED");
					isPlaying = false;
					sendSignal(YTPlayer.MOVIE_ENDED);
					break;
				
				case STATE_PLAYING: 
					trace("YTVideo::STATE_PLAYING");
					isPlaying = true;
					sendSignal(YTPlayer.MOVIE_PLAYING);
					break;
				
				case STATE_PAUSED: 
					trace("YTVideo::STATE_PAUSED");
					isPlaying = false;
					sendSignal(YTPlayer.MOVIE_PAUSED);
					break;
				
				case STATE_CUED: 
					trace("YTVideo::STATE_CUED");
					sendSignal(YTPlayer.MOVIE_CUED);
					break;
			}
		}
		
		override public function execute(s:Signal):void
		{
		
		}
	
	}

}