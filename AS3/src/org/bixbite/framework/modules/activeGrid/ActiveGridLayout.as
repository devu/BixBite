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

package org.bixbite.framework.modules.activeGrid 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.activeGrid.behaviour.CalculateGrid;
	import org.bixbite.framework.modules.activeGrid.data.ActiveGridData;
	import org.bixbite.framework.modules.activeGrid.view.ActiveGridView;
	import org.bixbite.framework.modules.stageManager.StageManager;
	import org.bixbite.framework.signals.StageSignal;
	
	/**
	 * @version  compatibility - 0.5.3
	 * @since 0.5.3
	 */
	public class ActiveGridLayout extends Compound 
	{
		
		public function ActiveGridLayout() 
		{
			var stageManager	:StageManager 	= new StageManager();
			
			var data			:ActiveGridData = new ActiveGridData();
			data.addBox(24, 3, 0xFF1111);
			data.addBox(3, 3, 0x00FF11);
			data.addBox(6, 3, 0x1111FF);
			data.addBox(3, 6, 0xFFFF11);
			data.addBox(3, 3, 0xFF11FF);
			data.addBox(3, 6, 0x00FFFF);
			
			var debugView		:ActiveGridView = new ActiveGridView();
			stageView.addView(debugView);
			
			addBehaviour(StageSignal.RESIZE, CalculateGrid);
		}
		
	}

}