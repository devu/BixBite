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
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.vo.ContextLoaderItem;
	import org.bixbite.framework.signal.ContextLoaderSignal;
	
	/**
	 * @version  compatibility - 0.6.2
	 * @since 0.6.2
	 */
	public class ContextLoaderData extends Data 
	{
		private var loaderContext	:LoaderContext;
		
		private var cache			:Dictionary = new Dictionary();
		
		private var queue			:Array = [];
		
		private var inProgress		:Boolean = false;
		
		private var totalProgress	:Number = 0;
		private var max				:int = 0;
		
		public function ContextLoaderData()
		{
			loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
		}
		
		override public function init():void 
		{
			addSlot(ContextLoaderSignal.LOAD			, onLoadContext);
			addSlot(ContextLoaderSignal.SET_PRIORITY	, onSetPriority);
		}
		
		private function onSetPriority(s:Signal):void
		{
			var name		:String = s.params.name;
			var priority	:String = s.params.priority;
			var index		:int 	= 0;
			
			trace(this, "onSetPriority", name, priority);
			
			for each(var item:ContextLoaderItem in queue) {
				if (item.name == name) {
					trace("detected", index);
					queue.splice(0, 0, queue.splice(index, 1)[0]);
					item.load(loaderContext);
				} else {
					trace("pause", index);
					item.pause();
				}
				index++
			}
			
			//reasume async loaders
			for each(item in queue) {
				if (item.async) item.load(loaderContext);
			}
		}
		
		private function onLoadContext(s:Signal):void 
		{
			var p:Object = s.params;
			var item:ContextLoaderItem;
			
			//if not in the cache
			if (cache[p.name] == undefined){
				
				item = new ContextLoaderItem(p.cache, p.viewUID, p.name, p.path, p.container);
				item.setCallbacks(onItemProgress, onItemComplete, onIOError);
				item.async = p.async;
				
				if (item.cache) cache[item.name] = item;
				
				queue.push(item);
				
				if (!inProgress){
					inProgress = true;
					runQueue();
					max = 1;
				} else {
					max++;
				}
				
				//start all async items
				if (item.async) item.load(loaderContext);
			}
		}
		
		private function runQueue():void 
		{
			queue[0].load(loaderContext);
			/*
			for each(var item:ContextLoaderItem in queue) {
				if (item.async) item.load(loaderContext);
			}*/
		}
		
		private function doNext():void
		{
			if (queue.length > 0){
				runQueue();
			} else {
				inProgress = false;
				max = 0;
				totalProgress = 0;
				
				responseToAll(ContextLoaderSignal.QUEUE_COMPLETED);
			}
		}
		
		private function onItemProgress(item:ContextLoaderItem, percent:Number):void
		{
			var total:Number = totalProgress + item.percent;
			
			responseToAll(ContextLoaderSignal.ON_PROGRESS, 
			{
				totalProgress	:Number(total / max * 100).toPrecision(4), 
				itemName		:String(item.name),
				itemProgress	:Number(item.percent * 100).toPrecision(4)
			});
		}
		
		private function onItemComplete(item:ContextLoaderItem):void
		{
			totalProgress += item.percent;
			queue.shift();
			
			responseToAll(ContextLoaderSignal.LOADED, { viewUID:item.viewUID, name:item.name, context:item.context } );
			doNext();
		}
		
		private function onIOError(item:ContextLoaderItem):void
		{
			queue.shift();
			
			responseToAll(ContextLoaderSignal.SKIPPED, { viewUID:item.viewUID, name:item.name } );
			doNext();
		}
		
	}

}