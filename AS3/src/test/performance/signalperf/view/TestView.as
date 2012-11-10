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

package test.performance.signalperf.view 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Slot;
	import org.bixbite.core.View;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * @langversion	3.0
	 */
	public class TestView extends View
	{
		private var slot:Slot;
		private var output:TextField;
		
		public function TestView() 
		{
			
		}
		
		override public function init():void 
		{
			var context:Sprite = new Sprite();
			context.mouseEnabled = false;
			stage.addChild(context);
			
			output = new TextField();
			output.autoSize = "left";
			output.text = "Click to test";
			context.addChild(output);
			
			addSlot(SignalPerformance.BEGIN_TEST, onBeginTest);
			addSlot(SignalPerformance.RUN_TEST_SRS, onRunTestSRS);
			addSlot(SignalPerformance.RUN_TEST_STANDARD, onRunTestStandard);
		}
		
		private function onRunTestSRS(s:Signal):void 
		{
			
		}
		
		private function onRunTestStandard(s:Signal):void 
		{
			
		}
		
		private function onBeginTest(s:Signal):void
		{
			output.text = "Running...";
			setTimeout(startTest, 1000);
		}
		
		private function startTest():void
		{
			var max:int = 100000;
			output.text = max + " iterations, " + String(max * 3) + " signals\n";
			
			slot = getSlots(SignalPerformance.RUN_TEST_SRS).getSlotByIndex(0);
			
			var startTime:int = getTimer();
			for (var i:int = 0 ; i < max; i++) sendSignal(SignalPerformance.RUN_TEST_STANDARD);
			output.appendText("STANDARD: " + String(getTimer() - startTime + "ms \n"));
			
			startTime = getTimer();
			for (i = 0 ; i < max; i++) slot.send(signal);
			output.appendText("STRONG SRS: " + String(getTimer() - startTime + "ms \n"));
		}
	}

}