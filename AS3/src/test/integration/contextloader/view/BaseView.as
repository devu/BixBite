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
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.ContextLoaderSignal;
	
	/**
	 * @langversion	3.0
	 */
	public class BaseView extends View 
	{
		private var loadContextSRS		:Function;
		
		public function BaseView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(ContextLoaderSignal.LOADED, onContextLoaded);
			loadContextSRS = getSlotReference(ContextLoaderSignal.LOAD)[0];
		}
		
		/**
		 * 
		 * @param	name
		 * @param	path
		 * @param	async
		 */
		public function loadContext(name:String, path:String, cache:Boolean = false, queueID:String = "async"):void
		{
			// SRS
			signal.params = { name:name, path:path, cache:cache, queueID:queueID };
			loadContextSRS(signal);
		}
		
		/**
		 * Internal abstract method
		 * @param	s
		 */
		internal function onContextLoaded(s:Signal):void { }
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			loadContextSRS 		= null;
			super.destroy();
		}
	}
}