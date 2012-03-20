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

package org.bixbite.framework.controller 
{
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import org.bixbite.core.Controller;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.signal.StageSignal;
	
	
	/**
	 * StageController, controls common and basic native flash player stage behaviour for displayable objects. 
	 * Provides additional values such as center of the stage and orientation.
	 * 
	 * @langversion	3.0
	 * @version 0.4.1
	 * @since 0.2.9
	 */
	public class StageController extends Controller 
	{
		public static const ORIENTATION_PORTRAIT		:String = "stageOrientationPortrait";
		public static const ORIENTATION_LANDSCAPE		:String = "stageOrientationLandscape";
		
		public static const SCREEN_FACTOR_DESKTOP		:String = "stageScreenFactorDesktop";
		public static const SCREEN_FACTOR_DESKTOP_HD	:String = "stageScreenFactorDesktopHD";
		public static const SCREEN_FACTOR_TABLET		:String = "stageScreenFactorTablet";
		public static const SCREEN_FACTOR_MOBILE		:String = "stageScreenFactorMobile";
		public static const SCREEN_FACTOR_MOBILE_LARGE	:String = "stageScreenFactorMobileLarge";
		
		private var stageSignal		:StageSignal;
		private var orientation		:String;
		private var screenFactor	:String;
		private var stage			:Stage;
		
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
			this.stage = system.stage;
			
			stageSignal = new StageSignal();
			attachSignal(stageSignal);
			
			system.addListener(Event.RESIZE, onStageResize);
			system.addListener(FullScreenEvent.FULL_SCREEN, onStageFullScreen);
			
			invalidate();
			
			addSlot(StageSignal.UPDATE_REQUEST, onUpdateRequest);
			sendSignal(StageSignal.UPDATE);
		}
		
		private function onUpdateRequest(s:ISignal):StageSignal 
		{
			invalidate();
			sendSignal(StageSignal.UPDATE);
			return stageSignal
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
			
			if (stageSignal.orientation != orientation){
				orientation = stageSignal.orientation;
				sendSignal(StageSignal.UPDATE);
			}
			
			if (stage.stageWidth <= 480){
				stageSignal.screenFactor = SCREEN_FACTOR_MOBILE;
			} else if (stage.stageWidth > 480 && stage.stageWidth <= 640){
				stageSignal.screenFactor = SCREEN_FACTOR_MOBILE_LARGE;
			} else if (stage.stageWidth > 640 && stage.stageWidth <= 1024){
				stageSignal.screenFactor = SCREEN_FACTOR_TABLET;
			} else if (stage.stageWidth > 1024 && stage.stageWidth <= 1920) {
				stageSignal.screenFactor = SCREEN_FACTOR_DESKTOP;
			} else {
				stageSignal.screenFactor = SCREEN_FACTOR_DESKTOP_HD;
			}
			
			if (stageSignal.screenFactor != screenFactor){
				screenFactor = stageSignal.screenFactor;
				sendSignal(StageSignal.UPDATE);
			}
			
			stageSignal.centerWidth = stage.stageWidth * 0.5;
			stageSignal.centerHeight = stage.stageHeight * 0.5;
		}
		
	}

}