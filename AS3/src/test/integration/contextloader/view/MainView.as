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

package test.integration.contextloader.view 
{
	//import com.greensock.events.LoaderEvent;
	//import com.greensock.loading.display.ContentDisplay;
	//import com.greensock.loading.ImageLoader;
	//import com.greensock.loading.LoaderMax;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.ContextLoaderSignal;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @version  compatibility - 0.6.2
	 * 4 images 5000px x 3750px 4.27 MB to load in total
	 * Tested under same real broadband performance conditions (78.86Mbps, 12ms ping), timing is the best achieved after 10 runs.
	 */
	public class MainView extends BaseView 
	{
		private var mainViewContext:Sprite;
		private var xpos:int = 0;
		private var startTime:int;
		
		public function MainView() 
		{
			trace(this, uid);
		}
		
		override public function init():void 
		{
			super.init();
			
			addSlot(ContextLoaderSignal.ON_PROGRESS, onProgress);
			addSlot(ContextLoaderSignal.SKIPPED, onItemSkipped);
			addSlot(ContextLoaderSignal.QUEUE_COMPLETED, onAllCompleted);
			
			var anticache:Number = Math.random() * 0xFFFFFF;
			
			loadContext("test1", "examples.swf");
			loadContext("test2", "videos/example.flv");
			loadContext("test3", "images/example.jpg");
			
			// *async loading 4535ms
			
			//loadContext("myImage1", "http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache, true);
			//loadContext("myImage2", "http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache, true);
			//loadContext("myImage3", "http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache, true);
			//loadContext("myImage4", "http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache, true);
			
			// *LoaderMax 7994ms
			/*
			var queue:LoaderMax = new LoaderMax( { name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler } );
			
			//append several loaders
			queue.append( new ImageLoader("http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache, {name:"myImage1", container:stage}) );
			queue.append( new ImageLoader("http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache, {name:"myImage2", container:stage}) );
			queue.append( new ImageLoader("http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache, {name:"myImage3", container:stage}) );
			queue.append( new ImageLoader("http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache, {name:"myImage4", container:stage}) );
			
			//prioritize the loader named "myImage4"
			
			//start loading
			queue.load();
			*/
			
			startTime = getTimer();
		}
		
		private function onItemSkipped(s:Signal):void 
		{
			trace("Item not loaded:", s.params.name, s.params.error)
		}
		
		private function onAllCompleted(s:Signal):void 
		{
			trace("TOTAL TIME", getTimer() - startTime);
		}
		
		private function onProgress(s:Signal):void 
		{
			trace("PROGRESS:: ", s.params.itemName, "TOTAL:", s.params.totalProgress , "ITEM", s.params.itemProgress );
		}
		
		override internal function onContextLoaded(s:Signal):void 
		{
			trace(this, "onContextLoaded:", s.params.name);
			
			if(Loader(s.params.context).content is Bitmap){
				var img:Bitmap = Loader(s.params.context).content as Bitmap;
				img.x = xpos;
				img.scaleX = img.scaleY = .02;
				xpos += 100;
				stage.addChild(img);
			}
			
			stage.addChild(Loader(s.params.context).content);
			
		}
		
		/*
		//LoaderMax handlers
		private function progressHandler(e:LoaderEvent):void 
		{
			trace("progress: " + e.target.progress);
		}

		private function completeHandler(e:LoaderEvent):void 
		{
			var image:ContentDisplay = LoaderMax.getContent("photo1");
			trace(e.target + " is complete in", getTimer() - startTime);
		}
		 
		private function errorHandler(e:LoaderEvent):void 
		{
			trace("error occured with " + e.target + ": " + e.text);
		}*/
	}

}