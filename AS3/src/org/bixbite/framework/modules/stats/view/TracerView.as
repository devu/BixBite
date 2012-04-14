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
	 * ...
	 * @author Daniel Wasilewski
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