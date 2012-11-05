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

package org.bixbite.framework.behaviour 
{
	import flash.display.DisplayObject;
	import flash.utils.getTimer;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.ContextLoaderItemData;
	import org.bixbite.framework.data.ContextLoaderProgressData;
	import org.bixbite.framework.data.vo.ContextItem;
	import org.bixbite.framework.signal.ContextLoaderSignal;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @langversion	3.0
	 */
	public class ContextLoaderLoad extends Behaviour 
	{
		override public function init():void 
		{
			super.init();
			
			addResponder(ContextLoaderSignal.ON_PROGRESS, onProgress);
			addResponder(ContextLoaderSignal.LOADED, onContextLoaded);
			addResponder(ContextLoaderSignal.SKIPPED, onContextSkipped);
			addResponder(ContextLoaderSignal.QUEUE_COMPLETED, onQueueCompleted);
		}
		
		private function onQueueCompleted(data:IData):void 
		{
			sendSignal(ContextLoaderSignal.QUEUE_COMPLETED);
		}
		
		private function onProgress(data:ContextLoaderProgressData):void 
		{
			sendSignal(ContextLoaderSignal.ON_PROGRESS, data);
		}
		
		private function onContextLoaded(data:ContextLoaderItemData):void
		{
			emitSignal(DisplaySignal.SET_CONTEXT, data );
			sendSignalTo(data.viewUID, ContextLoaderSignal.LOADED, data );
		}
		
		private function onContextSkipped(data:IData):void 
		{
			sendSignal(ContextLoaderSignal.SKIPPED, data);
		}
		
		override public function execute(s:Signal):void 
		{
			sendRequest(ContextLoaderSignal.LOAD, s.params);
		}
		
	}

}