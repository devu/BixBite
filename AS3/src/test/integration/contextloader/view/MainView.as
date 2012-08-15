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
	
	import com.greensock.events.LoaderEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.vo.ContextBitmap;
	import org.bixbite.framework.signal.ContextLoaderSignal;
	
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
		private var output:TextField;
		
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
			
			output = new TextField();
			output.width = 300;
			output.x = 10;
			output.y = 300;
			stage.addChild(output);
			
			var anticache:Number = Math.random() * 0xFFFFFF;
			
			// total 5773ms
			
			loadContext("test1", "examples.swf");
			loadContext("test2", "http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache);
			
			loadContext("myImage1", "http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache, true, "queue1");
			loadContext("myImage2", "http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache, true, "queue1");
			loadContext("myImage3", "http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache, true, "queue1");
			loadContext("myImage4", "http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache, true, "queue1");
			
			//this queue will reuse items from cache
			loadContext("myImage5", "http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache, false, "queue2");
			loadContext("myImage6", "http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache, false, "queue2");
			loadContext("myImage7", "http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache, false, "queue2");
			loadContext("myImage8", "http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache, false, "queue2");
			
			
			//Same task with LoaderMax
			// *LoaderMax 11170ms
			/*
			var queue:LoaderMax = new LoaderMax( { name:"queue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler } );
			queue.append(new SWFLoader("examples.swf", {name:"mySwf", container:stage}));
			queue.load();
			
			var queue1:LoaderMax = new LoaderMax( { name:"queue1", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler } );
			
			//append several loaders
			queue1.append( new ImageLoader("http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache, {name:"myImage1", container:stage}) );
			queue1.append( new ImageLoader("http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache, {name:"myImage2", container:stage}) );
			queue1.append( new ImageLoader("http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache, {name:"myImage3", container:stage}) );
			queue1.append( new ImageLoader("http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache, {name:"myImage4", container:stage}) );
			queue1.load();
			
			var queue2:LoaderMax = new LoaderMax( { name:"queue2", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler } );
			
			//append several loaders
			queue2.append( new ImageLoader("http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache, {name:"myImage1", container:stage}) );
			queue2.append( new ImageLoader("http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache, {name:"myImage2", container:stage}) );
			queue2.append( new ImageLoader("http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache, {name:"myImage3", container:stage}) );
			queue2.append( new ImageLoader("http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache, {name:"myImage4", container:stage}) );
			queue2.load();
			*/
			startTime = getTimer();
		}
		
		private function onItemSkipped(s:Signal):void 
		{
			trace("Item not loaded:", s.params.name, s.params.error)
		}
		
		private function onAllCompleted(s:Signal):void 
		{
			output.text = "TOTAL TIME: " + String(getTimer() - startTime);
		}
		
		private function onProgress(s:Signal):void 
		{
			output.text = s.params.totalProgress + "%";
			//trace("PROGRESS:: ", s.params.itemName, "TOTAL:", s.params.totalProgress , "ITEM", s.params.itemProgress );
		}
		
		override internal function onContextLoaded(s:Signal):void 
		{
			var p:Object = s.params;
			
			if(p.contextItem is ContextBitmap){
				var img:Bitmap = p.contextItem.bitmap;
				img.x = xpos;
				img.scaleX = img.scaleY = .02;
				xpos += 100;
				stage.addChild(img);
			}
			
			stage.addChild(p.contextItem);
			
		}
		
		//LoaderMax handlers
		private function progressHandler(e:LoaderEvent):void 
		{
			trace("progress: " + e.target.progress);
		}

		private function completeHandler(e:LoaderEvent):void 
		{
			//var image:ContentDisplay = LoaderMax.getContent("photo1");
			output.text = "TOTAL TIME: " + String(getTimer() - startTime);
			stage.addChild(output);
		}
		 
		private function errorHandler(e:LoaderEvent):void 
		{
			trace("error occured with " + e.target + ": " + e.text);
		}
	}

}