package org.bixbite.examples.stats.view 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.bixbite.core.View;
	import org.bixbite.examples.stats.signal.StatsSignal;
	
	/**
	 * This little class is a subview of StatsView. Purpose of it is to only display traces.
	 */
	public class StatsTraceView extends View 
	{
		private var info_trace	:TextField;
		private var panel		:Sprite;
		
		/**
		 * Constructor, by this example we want to show you when the usage of super() is needed. 
		 * We need reference to the injected panel to be available before init() is triggered.
		 * So, after referencing it to local variable we calling super() to change order of execution.
		 * @param	panel
		 */
		public function StatsTraceView(panel:Sprite) 
		{
			this.panel = panel;
			super();
		}
		
		override public function init():void 
		{
			info_trace = createText(0, 56, 0xFFFFFF, 300, 54);
			info_trace.backgroundColor = 0x000000;
			info_trace.background = true;
			info_trace.autoSize = "left";
			panel.addChild(info_trace);
			
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
			t.selectable = false;
			
			return t;
		}
		
	}

}