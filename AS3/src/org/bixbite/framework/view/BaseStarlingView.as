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

package org.bixbite.framework.view 
{
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.signal.StageSignal;
	import starling.display.DisplayObject;
	import starling.display.Stage;
	
	/**
	 * This is abstract Class for Views, 2nd level of abstraction to encapsulate common set of methods
	 * It works with connection with DisplayListManager Module and StageManager
	 * @langversion 3.0
	 */
	public class BaseStarlingView extends View 
	{
		private var _stage2D:Stage;
		
		override public function init():void 
		{
			addSlot("Starling.Stage2D", onStage2d);
			
			addSlot(DisplaySignal.CONTEXT_ADDED, onContext2DAdded);
			addSlot(DisplaySignal.CONTEXT_REMOVED, onContext2DRemoved);
		}
		
		private function onStage2d(s:Signal):void 
		{
			trace(this, "Stage2D");
			_stage2D = Stage(s.params);
			sendSignal("Starling.Stage2D", stage2D);
			stage2DReady();
		}
		
		private function onContext2DAdded(s:Signal):void 
		{
			addSlot(StageSignal.ON_RESIZE, onStageResize);
			context2DAdded();
			draw();
		}
		
		private function onContext2DRemoved(s:Signal):void 
		{
			context2DRemoved();
		}
		
		private function onStageResize(s:Signal):void 
		{
			resize();
			draw();
		}
		
		/*abstract*/ public function stage2DReady():void { }
		/*abstract*/ public function context2DAdded():void { }
		/*abstract*/ public function context2DRemoved():void { }
		/*abstract*/ public function resize():void { }
		/*abstract*/ public function draw():void { }
		
		public function setContext2D(name:String, context:DisplayObject, container:String = null):void
		{
			sendSignal(DisplaySignal.SET_CONTEXT, { name:name, context:context } );
			if (container) addContext2D(name, container);
		}
		
		public function addContext2D(name:String, container:String = "stage2D"):void
		{
			sendSignal(DisplaySignal.ADD_CONTEXT, { name:name, container:container} );
		}
		
		public function removeContext2D(name:String):void
		{
			sendSignal(DisplaySignal.REMOVE_CONTEXT, { name:name } );
		}
		
		override public function destroy():void 
		{
			removeSlot("Starling.Stage2D");
			removeSlot(StageSignal.ON_RESIZE);
			removeSlot(DisplaySignal.CONTEXT_ADDED);
			removeSlot(DisplaySignal.CONTEXT_REMOVED);
			removeSlot(DisplaySignal.CONTEXT_SET);
			
			super.destroy();
		}
		
		public function get stage2D():Stage 
		{
			return _stage2D;
		}
		
	}
	
}