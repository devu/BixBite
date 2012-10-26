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
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.utils.Dictionary;
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.vo.ContextLoaderItem;
	import org.bixbite.framework.signal.ContextLoaderSignal;
	
	/**
	 * @langversion	3.0
	 */
	public class ContextLoaderData extends Data 
	{
		private var maxSimConnections	:int = 10;
		private var openedConnections	:int = 0;
		
		private var loaderContext		:LoaderContext;
		
		private var cache				:Dictionary = new Dictionary();
		private var queues				:Dictionary = new Dictionary();
		
		private var queue				:Array = [];
		
		private var inProgress			:Boolean = false;
		
		private var totalProgress		:Number = 0;
		private var max					:int = 0;
		private var queueLoadedIndex	:int = 0;
		private var queueCompleteIndex	:int = 0;
		private var isLocal				:Boolean;
		
		public function ContextLoaderData()
		{
			isLocal = new RegExp("file://").test(stage.loaderInfo.url);
			
			if (isLocal){
				loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			} else {
				Security.loadPolicyFile("www.bixbite.org/crossdomain.xml");
				loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			}
		}
		
		override public function init():void 
		{
			addSlot(ContextLoaderSignal.LOAD			, onLoadContext);
			addSlot(ContextLoaderSignal.SET_PRIORITY	, onSetPriority);
		}
		
		private function onLoadContext(s:Signal):void 
		{
			var p:Object = s.params;
			
			//if not in the cache
			if (cache[p.name] == undefined){
				
				var item:ContextLoaderItem = new ContextLoaderItem(max, p.queueID, p.cache, p.viewUID, p.name, p.path, p.container);
				item.setCallbacks(onItemProgress, onItemComplete, onIOError);
				
				if (item.cache) cache[item.name] = item;
				
				queue.push(item);
				max++;
				
				executeQueue();
			} else {
				trace("item in cache");
			}
		}
		
		private function executeQueue():void 
		{
			var item	:ContextLoaderItem;
			var loaded	:int = 0;
			openedConnections = 0;
			
			for each(item in queue) 
			{
				if (item.completed){
					loaded++
				} else if (item.loading){
					openedConnections++
				} else {
					trace("load item:", item.name)
					item.load(loaderContext);
					openedConnections++
				}
				
				if (openedConnections == maxSimConnections) return
				
			}
			
			if (loaded == max){
				trace("ALL COMPLETE");
				responseToAll(ContextLoaderSignal.QUEUE_COMPLETED);
				for each(item in queue) {
					queue.shift();
					item = null;
				}
			}
			
		}
		
		private function onSetPriority(s:Signal):void
		{
			var item		:ContextLoaderItem
			var p			:Object 	= s.params;
			var name		:String 	= p.name;
			var priority	:String 	= p.priority;
			var index		:int 		= 0;
			var present		:Boolean 	= false;
			
			for each(item in queue) {
				if (item.name == name) {
					present = true;
					break;
				}
			}
			
			if (!present) return
			
			for each(item in queue) {
				if (item.name == name) {
					queue.splice(queueCompleteIndex, 0, queue.splice(index, 1)[0]);
					queue[queueCompleteIndex].index = 0;
				} else {
					item.pause();
				}
				
				index++
			}
			
			for (var i:int = item.index; i < max; i++) queue[i].index = i;
			
			executeQueue();
		}
		
		private function onItemProgress(item:ContextLoaderItem, percent:Number):void
		{
			var total:Number = 0;
			for each(var i:ContextLoaderItem in queue){
				total += i.percent;
			}
			
			var progressData:ContextLoaderProgressData = new ContextLoaderProgressData();
			progressData.totalProgress 	= total / max * 100;
			progressData.itemName 		= item.name;
			progressData.itemProgress 	= item.percent * 100;
			
			responseToAll(ContextLoaderSignal.ON_PROGRESS, progressData);
		}
		
		private function onItemComplete(index:int):void
		{
			queueLoadedIndex++;
			
			var item:ContextLoaderItem
			for (var i:int = queueCompleteIndex; i < queueLoadedIndex; i++) {
				item = queue[i];
				
				if (!item || !item.loaded) return;
				
				if (!item.completed) {
					item.completed = true;
					queueCompleteIndex++;
					responseToAll(ContextLoaderSignal.LOADED, new ContextLoaderItemData(item) );
				}
			}
			
			executeQueue();
		}
		
		private function onIOError(item:ContextLoaderItem, error:String):void
		{
			responseToAll(ContextLoaderSignal.SKIPPED, new ContextLoaderItemData(item, error));
			executeQueue();
		}
		
	}

}