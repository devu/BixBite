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

package org.bixbite.framework.data.vo 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * @version  compatibility - 0.6.2
	 * @since 0.6.2
	 */
	public class ContextLoaderItem 
	{
		private var loader		:Loader;
		
		public var cache		:Boolean = false;
		public var loading		:Boolean = false;
		public var loaded		:Boolean = false;
		public var completed	:Boolean = false;
		public var index		:int;
		
		public var viewUID		:String;
		public var queueID		:String;
		public var name			:String;
		public var path			:String;
		
		public var context		:ContextItem;
		public var containerId	:String;
		
		public var percent		:Number = 0;
		
		public var onComplete	:Function;
		public var onIOError	:Function;
		public var onProgress	:Function;
		
		public function ContextLoaderItem(index:int, queueID:String, cache:Boolean, viewUID:String, name:String, path:String, containerId:String) 
		{
			this.index 			= index;
			this.queueID 		= queueID;
			this.cache 			= cache;
			this.viewUID 		= viewUID;
			this.name 			= name;
			this.path 			= path;
			this.containerId 	= containerId;
		}
		
		public function load(loaderContext:LoaderContext):void 
		{
			if(!loading && !loaded){
				loading = true;
				loader = new Loader();
				
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				loader.load(new URLRequest(path), loaderContext);
			}
		}
		
		public function setCallbacks(onItemProgress:Function, onItemComplete:Function, onIOError:Function):void 
		{
			this.onProgress	= onItemProgress;
			this.onComplete = onItemComplete;
			this.onIOError 	= onIOError;
		}
		
		public function pause():void 
		{
			if (loading && !loaded){
				loader.close();
				loaded = loading = false;
			}
		}
		
		private function onProgressHandler(e:ProgressEvent):void 
		{
			percent = e.target.bytesLoaded / e.target.bytesTotal;
			onProgress(this, percent * 100);
		}
		
		private function onCompleteHandler(e:Event):void 
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			
			loading = false;
			loaded 	= true;
			
			if (loader.content is Bitmap){
				context = new ContextBitmap();
			} 
			
			if (loader.content is Sprite){
				context = new ContextSprite();
			} 
			
			context.content = loader.content;
			
			loader.unloadAndStop(true);
			loader = null;
			
			onComplete(index);
		}
		
		private function onIOErrorHandler(e:IOErrorEvent):void 
		{
			loading = false;
			onIOError(this, e.text);
		}
		
	}

}