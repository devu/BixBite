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
	import flash.display.Stage;
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.data.StageData;
	import org.bixbite.framework.StageManager;
	import org.bixbite.namespaces.STAGE_MGR;
	
	/**
	 * @langversion	3.0
	 */
	public class ResizeStage extends Behaviour 
	{
		use namespace STAGE_MGR;
		
		private var stageData	:StageData;
		private var stage		:Stage;
		
		public function ResizeStage() 
		{
			
		}
		
		override public function init():void
		{
			addResponder(StageManager.DATA_REQUEST, onData, true);
		}
		
		private function onData(s:Signal, data:StageData):void
		{
			removeResponder(StageManager.DATA_REQUEST);
			
			this.stageData = data;
			stage = stageData.stage;
			stageData.orientation = (stage.stageWidth <= stage.stageHeight) ? StageData.PORTRAIT : StageData.LANDSCAPE;
		}
		
		override public function execute(s:Signal):void
		{
			var currentOrientation:String = (stage.stageWidth <= stage.stageHeight) ? StageData.PORTRAIT : StageData.LANDSCAPE;
			
			if (stageData.orientation != currentOrientation){
				stageData.orientation = currentOrientation;
				sendSignal(StageSignal.ON_ORIENTATION_CHANGED, { orientation:currentOrientation } );
			}
			
			sendSignal(StageSignal.ON_RESIZE, { width:stage.stageWidth, height:stage.stageHeight } );
		}
		
		override public function dispose():void 
		{
			removeResponder(StageManager.DATA_REQUEST);
			
			stageData = null;
			stage = null;
			
			super.dispose();
		}
		
	}

}