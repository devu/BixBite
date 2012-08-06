package org.bixbite.framework.data.vo 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ContextLoaderItem 
	{
		private var loader		:Loader;
		public var cache		:Boolean = false;
		public var loading		:Boolean = false;
		public var loaded		:Boolean = false;
		public var async		:Boolean = false;
		
		public var viewUID		:String;
		public var name			:String;
		public var path			:String;
		public var context		:DisplayObject;
		public var containerId	:String;
		
		public var percent		:Number = 0;
		
		public var onComplete	:Function;
		public var onIOError	:Function;
		public var onProgress	:Function;
		
		
		public function ContextLoaderItem(cache:Boolean, viewUID:String, name:String, path:String, containerId:String) 
		{
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
				context = new Loader();
				
				Loader(context).contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
				Loader(context).contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
				Loader(context).contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				Loader(context).load(new URLRequest(path), loaderContext);
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
				Loader(context).close();
				loading = false;
			}
		}
		
		private function onProgressHandler(e:ProgressEvent):void 
		{
			percent = e.target.bytesLoaded / e.target.bytesTotal;
			onProgress(this, percent * 100);
		}
		
		private function onCompleteHandler(e:Event):void 
		{
			Loader(context).contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
			Loader(context).contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			Loader(context).contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			
			loading = false;
			loaded 	= true;
			
			onComplete(this);
		}
		
		private function onIOErrorHandler(e:Event):void 
		{
			loading = false;
			onIOError(this);
		}
		
	}

}