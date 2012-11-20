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

package examples.starling.view 
{
	
	import org.bixbite.core.Signal;
	import org.bixbite.framework.view.BaseStarlingView;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class StarlingTestView extends BaseStarlingView 
	{
		private var context2D	:Sprite;
		private var quadA		:Quad;
		private var quadB		:Quad;
		private var textField	:TextField;
		
		override public function init():void 
		{
			super.init();
			
			context2D = new Sprite();
			
			textField = new TextField(400, 300, "Welcome to Starling!");
			textField.name = "text"; 
			//unfortunatelly this does not work and the Straling TextField is being detected as Image
			
			quadA = new Quad(100, 100);
			quadA.x = 100;
			quadA.y = 180;
			quadA.setVertexColor(0, 0x1c1191);
			quadA.setVertexColor(1, 0x1c1191);
			quadA.setVertexColor(2, 0xea0b0b);
			quadA.setVertexColor(3, 0xea0b0b);
			
			quadB = new Quad(100, 100);
			quadB.x = 160;
			quadB.y = 200;
			quadB.setVertexColor(0, 0x547891);
			quadB.setVertexColor(1, 0x1c1191);
			quadB.setVertexColor(2, 0x440b0b);
			quadB.setVertexColor(3, 0xFF0b0b);
			
			addSlot("Starling.MOUSE_DOWN", onMouseDown);
		}
		
		private function onMouseDown(s:Signal):void 
		{
			textField.text = s.params.text;
		}
		
		override public function stage2DReady():void 
		{
			setContext2D("test", context2D, "stage2D");
			setContext2D("myText", textField, "test");
			setContext2D("myQuadA", quadA, "test");
			setContext2D("myQuadB", quadB, "test");
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
	
}