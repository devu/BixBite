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

package examples.starling.transponder 
{
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.utils.ClassUtil;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Stage;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class StarlingTransponder extends Transponder 
	{
		private var stage2D:Stage;
		
		override public function init():void 
		{
			addSlot("Starling.Stage2D", onStage2d);
		}
		
		private function onStage2d(s:Signal):void 
		{
			removeSlot("Starling.Stage2D");
			
			this.stage2D = Stage(s.params);
			addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var obj:DisplayObject = stage2D.hitTest(new Point(stage.mouseX, stage.mouseY));
			
			if (obj is Quad) {
				var name:String = ClassUtil.retrieveName(obj);
				var uid:String = ClassUtil.retrieveUID(obj);
				if (uid) responseTo(uid, "Starling.MOUSE_DOWN", { text: obj.name } );
			}
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
	
}