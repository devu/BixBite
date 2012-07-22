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

package org.bixbite.framework.transponder 
{
	import flash.events.Event;
	import org.bixbite.core.interfaces.ICompound;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	import org.bixbite.namespaces.STAGE_MGR;
	
	/**
	 * @version  compatibility - 0.6.1
	 * @since 0.4.1
	 */
	public class StageTransponder extends Transponder 
	{
		use namespace STAGE_MGR
		
		public function StageTransponder() 
		{
			
		}
		
		override public function init():void 
		{
			addSensor(Event.RESIZE, onStageResize);
			
			transmit(StageSignal.SET_STAGE);
		}
		
		private function onStageResize(e:Event):void 
		{
			sendSignal(StageManager.RESIZE);
		}
		
		override public function destroy():void 
		{
			removeSensor(Event.RESIZE, onStageResize);
			removeSlot(StageSignal.SET_STAGE);
			
			super.destroy();
		}
	}

}