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

package examples.helloflash.view 
{
	import examples.helloflash.signal.BallSignal;
	import flash.text.TextField;
	import org.bixbite.framework.view.StageView;
	
	/**
	 * @version  compatibility - 0.4.5
	 */
	public class MainView extends StageView 
	{
		private var textField:TextField;
		
		public function MainView() 
		{
			
		}
		
		override public function init():void 
		{
			super.init();
			
			textField = new TextField();
			textField.selectable = false;
			system.stage.addChild(textField);
			
			addSlot(BallSignal.CREATE_BALL, onCreateBall);
		}
		
		// Add a Ball to the view
		private function onCreateBall(s:BallSignal):void
		{
			textField.text = "Click count:" + s.count;
			
			var ball:Ball = new Ball();
			ball.x = Math.random() * 500;
			ball.y = Math.random() * 375;
			addView(ball);
		}
		
	}

}