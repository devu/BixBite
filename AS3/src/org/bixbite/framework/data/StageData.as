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
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	import org.bixbite.namespaces.STAGE_MGR;
	
	/**
	 * @version  compatibility - 0.6.2
	 * @since 0.4.1
	 */
	public class StageData extends Data
	{
		
		
		public static const PORTRAIT	:String = "PORTRAIT";
		public static const LANDSCAPE	:String = "LANDSCAPE";
		
		public var orientation			:String;
		
		use namespace STAGE_MGR
		
		public function StageData()
		{
			
		}
		
		override public function init():void 
		{
			addSlot(StageManager.DATA_REQUEST, onDataRequest);
			addSlot(StageSignal.SET_STAGE, onStageSet);
		}
		
		private function onDataRequest(s:Signal):void
		{
			responseTo(s.callerUID, StageManager.DATA_REQUEST);
		}
		
		private function onStageSet(s:Signal):void
		{
			stage.align 		= s.params.align;
			stage.scaleMode 	= s.params.scaleMode;
		}
		
		override public function destroy():void 
		{
			removeSlot(StageManager.DATA_REQUEST);
			removeSlot(StageSignal.SET_STAGE);
			
			orientation = null;
			
			super.destroy();
		}
		
	}
}