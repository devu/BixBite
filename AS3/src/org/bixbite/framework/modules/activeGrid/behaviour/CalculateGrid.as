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

package org.bixbite.framework.modules.activeGrid.behaviour 
{
	import flash.display.Stage;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.modules.activeGrid.data.ActiveGridData;
	import org.bixbite.framework.modules.stageManager.data.StageData;
	import org.bixbite.framework.signals.ActiveGridSignal;
	import org.bixbite.framework.signals.StageSignal;
	
	/**
	 * @version  compatibility - 0.5.3
	 * @since 0.5.3
	 */
	public class CalculateGrid extends Behaviour 
	{
		private var stageData	:StageData;
		private var gridData	:ActiveGridData;
		private var stage		:Stage;
		
		private var col			:int = 0;
		private var row			:int = 0;
		
		private var boxes		:Array;
		
		public function CalculateGrid() 
		{
			
		}
		
		override public function init():void 
		{
			addResponder(StageSignal.DATA_REQUEST, onStageData, true);
			addResponder(ActiveGridSignal.DATA_REQUEST, onGridData, true);
		}
		
		private function onStageData(s:ISignal, data:StageData):void
		{
			this.stageData 	= data;
			this.stage 		= data.stage;
		}
		
		private function onGridData(s:ISignal, data:ActiveGridData):void
		{
			this.gridData 	= data;
			boxes = data.boxes;
			
			col = checkHRange();
			row = checkVRange();
			
			sendSignal(ActiveGridSignal.SET_GRID, [col, row, gridData.moduleSize]);
			
			distribute();
		}
		
		override public function execute(s:ISignal):void 
		{
			var c:int = checkHRange();
			if (col != c) {
				col = c;
				sendSignal(ActiveGridSignal.SET_GRID, [col, row, gridData.moduleSize]);
			}
			
			var r:int = checkVRange();
			if (row != r) {
				row = r;
				sendSignal(ActiveGridSignal.SET_GRID, [col, row, gridData.moduleSize]);
			}
			
			distribute();
		}
		
		private function distribute():void 
		{
			var rect		:Object
			var box			:Object;
			var index		:int = 0;
			
			var areas		:Array 	= [];
			areas[index] 	= { x:0, y:0, w:0, h:0 };
			
			var array		:Array 	= [];
			var i			:int = 0;
			
			
			for each(var b:Object in boxes)
			{
				box = array[i] = { x:b.x, y:b.y, w:b.w, h:b.h, color:b.color };
				
				rect = areas[index];
				
				box.x = rect.w;
				box.y = rect.y;
				
				if (rect.w + box.w > col ) {
					box.x = 0;
					box.y = rect.y + rect.h;
					
					index++;
					areas[index] = { x:box.w, y:box.y, w:box.w, h:box.h };
				} else {
					if (box.h > rect.h) rect.h = box.h;
					rect.w += box.w;
				}
				i++;
			}
			
			sendSignal(ActiveGridSignal.DISTRIBUTE, [array, gridData.moduleSize]);
		}
		
		private function checkHRange():int
		{
			return Math.round((stage.stageWidth) / gridData.moduleSize);
		}
		
		private function checkVRange():int
		{
			return Math.round((stage.stageHeight) / gridData.moduleSize);
		}
		
	}

}