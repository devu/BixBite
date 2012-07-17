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
	import org.bixbite.framework.transponder.StageTransponder;
	
	/**
	 * @version  compatibility - 0.6.0
	 * @since 0.5.0
	 * 
	 * footprint 8.73kb
	 */
	public class StageManager extends Compound
	{
		//requests
		public static const SET_STAGE			:String = "StageSignal.SET_STAGE";
		public static const DATA_REQUEST		:String = "StageSignal.DATA_REQUEST";
		public static const RESIZE				:String = "StageSignal.RESIZE";
		
		//responses
		public static const ON_ORIENTATION_CHANGED	:String = "StageSignal.ON_ORIENTATION_CHANGED";
		public static const ON_RESIZE				:String = "StageSignal.ON_RESIZE";
		
		public function StageManager()
		{
			
		}
		
		override public function init():void 
		{
			register(StageData);
			register(StageTransponder);
			
			addBehaviour(StageManager.SET_STAGE, SetStage);
			addBehaviour(StageManager.RESIZE, ResizeStage);
		}
	}

}