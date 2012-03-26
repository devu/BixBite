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

package org.bixbite.core 
{
	import flash.display.Stage;
	import flash.geom.Point;
	
	/**
	 * SystemIO is a system input output provider. Is a bridge between application and enviroment that is operating with.
	 * In AS3 specific implementation SystemIO encapsulates native stage since this element can provide all needed access to certain part of Flash Player.
	 * Models can access stage.loaderInfo to get some external data as well as controll the output.
	 * Controllers can capture user inputs by adding native listeners.
	 * Views can access stage as 'top view' in nested view hierarhy.
	 * 
	 * @langversion	3.0
	 * @version 0.4.5
	 */
	public class SystemIO 
	{
		private var _stage:Stage;
		private var p:Point;
		
		/**
		 * Constructor, AS3 specific implementation.
		 * @param	stage, native flash stage reference
		 */
		public function SystemIO(stage:Stage) 
		{
			_stage = stage;
			p = new Point(0, 0);
		}
		
		/**
		 * Encapsulated native addEventListener method
		 * @param	type
		 * @param	listener
		 */
		public function addListener(type:String, listener:Function):void
		{
			stage.addEventListener(type, listener);
		}
		
		/**
		 * Encapsulated native removeEventListener method
		 * @param	type
		 * @param	listener
		 */
		public function removeListener(type:String, listener:Function):void
		{
			stage.removeEventListener(type, listener);
		}
		
		/**
		 * Helper method for Controllers to get references to objects under the point
		 * @return
		 */
		public function getObjects():Array
		{
			p.x = stage.mouseX;
			p.y = stage.mouseY;
			return stage.getObjectsUnderPoint(p);
		}
		
		/**
		 * Asses to native stage.
		 * It might not be needed when using framework, but using just a Core is the only way to start dealing with DisplayObjects and DisplayList
		 */
		public function get stage():Stage 
		{
			return _stage;
		}
		
	}

}