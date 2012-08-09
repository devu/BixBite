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
	import flash.utils.getTimer;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.ContextLoaderSignal;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @version  compatibility - 0.6.2
	 * @since 0.6.2
	 */
	public class ContextLoaderLoad extends Behaviour 
	{
		public function ContextLoaderLoad()
		{
			
		}
		
		override public function init():void 
		{
			super.init();
			
			addResponder(ContextLoaderSignal.ON_PROGRESS, onProgress);
			addResponder(ContextLoaderSignal.LOADED, onContextLoaded);
			addResponder(ContextLoaderSignal.SKIPPED, onContextSkipped);
			addResponder(ContextLoaderSignal.QUEUE_COMPLETED, onQueueCompleted);
		}
		
		private function onQueueCompleted(s:Signal, data:IData):void 
		{
			sendSignal(ContextLoaderSignal.QUEUE_COMPLETED);
		}
		
		private function onProgress(s:Signal, data:IData):void 
		{
			sendSignal(ContextLoaderSignal.ON_PROGRESS, s.params );
		}
		
		private function onContextLoaded(s:Signal, data:IData):void 
		{
			var p:Object = s.params;
			emitSignal(DisplaySignal.SET_CONTEXT, { viewUID:p.viewUID, name:p.name, context:p.context } );
			sendSignalTo(p.viewUID, ContextLoaderSignal.LOADED, { viewUID:p.viewUID, name:p.name, context:p.context } );
		}
		
		private function onContextSkipped(s:Signal, data:IData):void 
		{
			sendSignal(ContextLoaderSignal.SKIPPED, s.params);
		}
		
		override public function execute(s:Signal):void 
		{
			sendRequest(ContextLoaderSignal.LOAD, s.params);
		}
		
	}

}