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

package org.bixbite.framework.modules.stats.view 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.bixbite.framework.modules.stats.signal.StatsSignal;
	import org.bixbite.framework.view.DisplayViewContainer;
	
	/**
	 * @version  compatibility - 0.4.3
	 * @since 0.4.2
	 * 
	 * This is subview of StatsMonitor to extend its functionality for runtime trace output.
	 */
	public class StatsTracer extends DisplayViewContainer 
	{
		private var info_trace	:TextField;
		
		/**
		 * Constructor
		 */
		public function StatsTracer() 
		{
			
		}
		
		override public function init():void
		{
			super.init();
			
			info_trace = createText(0, 56, 0xFFFFFF, 300, 54);
			info_trace.backgroundColor = 0x000000;
			info_trace.background = true;
			info_trace.autoSize = "left";
			addChild(info_trace);
			
			addSlot(StatsSignal.DISPLAY_TRACE, onUpdateTrace);
		}
		
		private function onUpdateTrace(s:StatsSignal):void 
		{
			info_trace.text = s.infoTRACE;
		}
		
		private function createText(posX:Number, posY:Number, color:uint = 0xFFFFFF, w:Number = 70, h:Number = 18):TextField
		{
			var tf:TextFormat = new TextFormat("tahoma", 9, color);
			
			var t:TextField = new TextField();
			t.x = posX;
			t.y = posY;
			t.defaultTextFormat = tf;
			t.width = w;
			t.height = h;
			
			return t;
		}
		
	}

}