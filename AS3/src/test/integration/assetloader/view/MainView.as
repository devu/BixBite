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

package test.integration.assetloader.view 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.AssetSignal;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @version  compatibility - 0.6.2
	 * 4 images 5000px x 3750px 4.27 MB to load in total
	 */
	public class MainView extends BaseView 
	{
		private var mainViewContext:Sprite;
		private var xpos:int = 0;
		
		public function MainView() 
		{
			trace(this, uid);
		}
		
		override public function init():void 
		{
			super.init();
			
			addSlot(AssetSignal.CONTEXT_LOAD_PROGRESS, onProgress);
			
			var anticache:Number = Math.random() * 0xFFFFFF;
			
			// async loading 4878ms
			
			loadContext("myImage1", "http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache, true);
			loadContext("myImage2", "http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache, true);
			loadContext("myImage3", "http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache, true);
			loadContext("myImage4", "http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache, true);
			
			
			// queue loading 13412ms
			/*
			loadContext("myImage1", "http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache);
			loadContext("myImage2", "http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache);
			loadContext("myImage3", "http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache);
			loadContext("myImage4", "http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache);
			*/
			// this is nothing to do with this or any other framework, this is how much flash loaders sucks
		}
		
		private function onProgress(s:Signal):void 
		{
			trace("PROGRESS:: ", s.params.itemName, "TOTAL:", s.params.totalProgress , "ITEM", s.params.itemProgress );
		}
		
		override internal function onContextLoaded(s:Signal):void 
		{
			trace(this, "onContextLoaded:", s.params.name);
			var img:Bitmap = Loader(s.params.context).content as Bitmap;
			img.x = xpos;
			img.scaleX = img.scaleY = .02;
			xpos += 100;
			stage.addChild(img);
		}
	}

}