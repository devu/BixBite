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

package org.bixbite.classic.controller 
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import org.bixbite.classic.signal.StageSignal;
	import org.bixbite.core.Controller;
	import org.bixbite.core.interfaces.ISignal;
	
	/**
	 * StageController, controls common and basic native flash player stage behaviour for displayable objects. 
	 * Provides additional values such as center of the stage and orientation.
	 * 
	 * @langversion	3.0
	 * @version 0.2.10
	 */
	public class StageController extends Controller 
	{
		public static const ORIENTATION_PORTRAIT	:String = "stageOrientationPortrait";
		public static const ORIENTATION_LANDSCAPE	:String = "stageOrientationLandscape";
		
		private var stageSignal:StageSignal;
		private var currentOrientation:String;
		
		/**
		 * Constructor, provides injection for common settings.
		 */
		public function StageController(align:String = StageAlign.TOP_LEFT, scaleMode:String = StageScaleMode.NO_SCALE) 
		{
			stage.align = align;
			stage.scaleMode = scaleMode;
		}
		
		/**
		 * Initialise functionality of this controller.
		 * Attach custom signal, apply listeners into I/O provider (stage) and addSlot for eventual requests.
		 */
		override public function init():void 
		{
			stageSignal = new StageSignal();
			attachSignal(stageSignal);
			
			stage.addEventListener(Event.RESIZE, onStageResize);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onStageFullScreen);
			
			invalidate();
			sendSignal(StageSignal.UPDATE);
		}
		
		/**
		 * When Stage will change its displayState will broadcast StageSignal.UPDATE signal
		 * @param	e, native Event recieved from stage.
		 */
		private function onStageFullScreen(e:FullScreenEvent):void 
		{
			invalidate();
			sendSignal(StageSignal.UPDATE);
		}
		
		/**
		 * When Stage will change its size will broadcast StageSignal.RESIZE signal. 
		 * If size of stage will affect orientation StageSignal.UPDATE will be fired.
		 * @param	e, native Event recieved from stage.
		 */
		private function onStageResize(e:Event):void 
		{
			invalidate();
			sendSignal(StageSignal.RESIZE);
		}
		
		/**
		 * Update all values needed to be send within a signal.
		 */
		private function invalidate():void 
		{
			stageSignal.orientation = (stage.stageWidth > stage.stageHeight) ? ORIENTATION_LANDSCAPE : ORIENTATION_PORTRAIT;
			if (stageSignal.orientation != currentOrientation){
				currentOrientation = stageSignal.orientation;
				sendSignal(StageSignal.UPDATE);
			}
			stageSignal.centerWidth = stage.stageWidth * 0.5;
			stageSignal.centerHeight = stage.stageHeight * 0.5;
		}
		
	}

}