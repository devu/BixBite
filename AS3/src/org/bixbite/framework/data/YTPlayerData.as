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

package org.bixbite.framework.data 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.YTPlayer;
	
	/**
	 * @version  compatibility - 0.6.1
	 * @since 0.6.1
	 */
	public class YTPlayerData extends Data 
	{
		private static const PLAYER_URL			:String = "http://www.youtube.com/apiplayer?version=3";
		private static const SECURITY_DOMAIN	:String = "http://www.youtube.com";
		
		private var loader		:Loader;
		private var isLoading	:Boolean = false;
		private var markToDestroy:Boolean;
		
		public var player		:Object;
		public var videoId		:String;
		public var autoPlay		:Boolean = true;
		
		public function YTPlayerData() 
		{
			Security.allowDomain(SECURITY_DOMAIN);
		}
		
		override public function init():void 
		{
			addSlot(YTPlayer.INIT, initPlayer);
		}
		
		private function initPlayer(s:Signal):void 
		{
			isLoading = true;
			
			var p:Object = s.params;
			
			if (p.videoId) videoId = p.videoId;
			if (p.autoPlay) autoPlay = p.autoPlay;
			
			loadPlayerComponent();
		}
		
		private function loadPlayerComponent():void 
		{
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPlayerReady);
			loader.load(new URLRequest(PLAYER_URL), context);
		}
		
		private function onPlayerReady(e:Event):void 
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPlayerReady);
			
			if (markToDestroy) {
				loader.unloadAndStop();
				loader = null;
				return;
			}
			trace("loaded anyway")
			
			player = loader.content;
			player.mouseEnabled = false;
			player.mouseChildren = false;
			
			loader.unloadAndStop();
			loader = null;
			
			responseToAll(YTPlayer.ON_INIT);
		}
		
		public function play(videoId:String = null, startSeconds:Number = 0, suggestedQuality:String = "default"):void
		{
			if (videoId != null){
				if (this.videoId != videoId){
					this.videoId = videoId;
				} else {
					//reasume
				}
			}
			
			player.loadVideoById(this.videoId, startSeconds, suggestedQuality);
		}
		
		public function pause():void
		{
			player.pause();
		}
		
		override public function destroy():void 
		{
			markToDestroy = true;
			
			player = null;
			if (player) player.destroy();
			
			if(!isLoading){
				loader.unloadAndStop();
				loader = null;
			}
			
			super.destroy();
		}
		
	}

}