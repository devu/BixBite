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
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.factories.TextFactory;
	import org.bixbite.framework.signals.StatsSignal;
	import org.bixbite.framework.view.DisplayView;
	
	/**
	 * @version  compatibility - 0.5.0
	 * @since 0.4.2
	 */
	public class TracerView extends DisplayView 
	{
		private var info		:TextField;
		
		public function TracerView() 
		{
			
		}
		
		override public function init():void 
		{
			var textFactory:TextFactory = TextFactory.instance;
			
			var container:Sprite = new Sprite();
			container.y = 56;
			
			info 				= textFactory.createSimpleText(container, 0, 0, 200, 10, 0xFFFF66);
			info.background 	= true;
			info.backgroundColor = 0x000000;
			info.autoSize 		= "left";
			
			setContext("tracer", container);
			
			addSlot(StatsSignal.DISPLAY_TRACE, onDisplay);
		}
		
		private function onDisplay(s:ISignal):void 
		{
			info.text = s.params[0];
		}
	}

}