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

package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.ResizeStage;
	import org.bixbite.framework.behaviour.SetStage;
	import org.bixbite.framework.data.StageData;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.transponder.StageTransponder;
	import org.bixbite.namespaces.STAGE_MGR;
	
	/**
	 * @langversion	3.0
	 */
	public class StageManager extends Compound
	{
		use namespace STAGE_MGR
		
		STAGE_MGR static const DATA_REQUEST		:String = "StageSignal.DATA_REQUEST";
		STAGE_MGR static const RESIZE			:String = "StageSignal.RESIZE";
		
		public function StageManager()
		{
			
		}
		
		override public function init():void 
		{
			register(StageData);
			register(StageTransponder);
			
			addBehaviour(StageSignal.SET_STAGE, SetStage);
			addBehaviour(StageManager.RESIZE, ResizeStage);
		}
		
		override public function destroy():void 
		{
			removeBehaviour(StageSignal.SET_STAGE);
			removeBehaviour(StageManager.RESIZE);
			
			unregister(StageData);
			unregister(StageTransponder);
			
			super.destroy();
		}
	}

}