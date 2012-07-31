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

package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.*;
	import org.bixbite.framework.data.YTPlayerData;
	import org.bixbite.framework.transponder.YTPlayerTransponder;
	import org.bixbite.framework.view.YTPlayerBaseView;
	import org.bixbite.namespaces.YT_PLAYER;
	
	/**
	 * @version  compatibility - 0.6.2
	 * @since 0.6.1
	 */
	public class YTPlayer extends Compound 
	{
		use namespace YT_PLAYER
		//IN
		public static const INIT			:String = "YTPlayer.INIT";
		public static const PLAY			:String = "YTPlayer.PLAY_MOVIE";
		public static const STOP			:String = "YTPlayer.STOP_MOVIE";
		public static const PAUSE			:String = "YTPlayer.PAUSE_MOVIE";
		
		YT_PLAYER static const STATUS		:String = "YTPlayer.STATUS";
	
		//OUT
		public static const ON_INIT			:String = "YTPlayer.ON_INIT";
		public static const PLAYER_READY	:String = "YTPlayer.PLAYER_READY";
		public static const MOVIE_ENDED		:String = "YTPlayer.MOVIE_ENDED";
		public static const MOVIE_PLAYING	:String = "YTPlayer.MOVIE_PLAYING";
		public static const MOVIE_PAUSED	:String = "YTPlayer.MOVIE_PAUSED";
		public static const MOVIE_CUED		:String = "YTPlayer.MOVIE_CUED";
		
		public function YTPlayer() 
		{
			
		}
		
		override public function init():void 
		{
			register(YTPlayerData);
			register(YTPlayerTransponder);
			register(YTPlayerBaseView);
			
			addBehaviour(INIT, YTPlayerInit);
			addBehaviour(PLAY, YTVideoPlay);
			addBehaviour(PAUSE, YTVideoPause);
			addBehaviour(STATUS, YTPlayerStatus);
		}
		
		override public function destroy():void 
		{
			removeBehaviour(INIT);
			removeBehaviour(PLAY);
			removeBehaviour(PAUSE);
			removeBehaviour(STATUS);
			
			unregister(YTPlayerData);
			unregister(YTPlayerTransponder);
			unregister(YTPlayerBaseView);
			
			super.destroy();
		}
		
	}

}