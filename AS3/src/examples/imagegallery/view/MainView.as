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

package examples.imagegallery.view 
{
	import flash.display.Sprite;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.ContextLoaderSignal;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @version  compatibility - 0.6.2
	 */
	public class MainView extends BaseView 
	{
		private var mainViewContext:Sprite;
		
		public function MainView() 
		{
			trace(this, uid);
		}
		
		override public function init():void 
		{
			super.init();
			
			mainViewContext = new Sprite();
			addSlot(ContextLoaderSignal.CONTEXT_LOAD_PROGRESS, onProgress);
			
			setContext("mainView", mainViewContext);
			
			var anticache:Number = Math.random() * 0xFFFFFF;
			
			// async loading 5782ms
			//loadContext("myImage1", "http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache, true);
			//loadContext("myImage2", "http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache, true);
			//loadContext("myImage3", "http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache, true);
			//loadContext("myImage4", "http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache, true);
			
			// queue loading 13412ms
			
			loadContext("myImage1", "http://www.psdgraphics.com/file/abstract-background.jpg?cache=" + anticache);
			loadContext("myImage2", "http://abstractwallpapers.biz/wp-content/uploads/2012/04/blue-wallpaper.jpg?cache=" + anticache);
			loadContext("myImage3", "http://torimartin.com/wp-content/uploads/2010/11/abstract-light.jpg?cache=" + anticache);
			loadContext("myImage4", "http://www.psdgraphics.com/file/abstract-rings-background.jpg?cache=" + anticache);
			
			// this is nothing to do with this or any other framework, this is how much flash loaders sucks
		}
		
		private function onProgress(s:Signal):void 
		{
			trace("PROGRESS:: ", s.params.itemName, "TOTAL:", s.params.totalProgress , "ITEM", s.params.itemProgress );
		}
		
		override internal function onContextSet(s:Signal):void 
		{
			trace(this, "onContextSet:", s.params.name);
			
			mainViewContext.graphics.clear();
			mainViewContext.graphics.beginFill(0xFF0000, 1);
			mainViewContext.graphics.drawRect(0, 0, 200, 200);
		}
		
		override internal function onContextAdded(s:Signal):void 
		{
			trace(this, "onContextAdded:", s.params.name);
		}
		
		override internal function onContextRemoved(s:Signal):void 
		{
			trace(this, "onContextRemoved:", s.params.name);
		}
		
		override internal function onContextLoaded(s:Signal):void 
		{
			trace(this, "onContextLoaded:", s.params.name);
			addContext(s.params.name, "mainView");
		}
	}

}