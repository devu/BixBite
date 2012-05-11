package org.bixbite.framework.modules.activeGrid.view 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.signals.ActiveGridSignal;
	import org.bixbite.framework.view.DisplayView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ActiveGridView extends DisplayView 
	{
		private var content:Sprite;
		
		public function ActiveGridView() 
		{
			
		}
		
		override public function init():void 
		{
			content = new Sprite();
			setContext("activeGrid", content);
			
			addSlot(ActiveGridSignal.SET_GRID, onSetGrid);
			addSlot(ActiveGridSignal.DISTRIBUTE, onDistribute);
		}
		
		private function onSetGrid(s:ISignal):void
		{
			var col		:int = s.params[0];
			var row		:int = s.params[1];
			var size	:int = s.params[2];
			
			content.graphics.clear();
			
			for (var i:int = 0; i < col; i++) 
			{
				content.graphics.lineStyle(1, 0xFF0000);
				content.graphics.moveTo(i * size, 0);
				content.graphics.lineTo(i * size, stage.stageHeight);
			}
			
			for (var r:int = 0; r < row; r++) 
			{
				content.graphics.lineStyle(1, 0xFF0000);
				content.graphics.moveTo(0, r * size);
				content.graphics.lineTo(stage.stageWidth, r * size);
			}
		}
		
		private function onDistribute(s:ISignal):void 
		{
			var boxes:Array = s.params[0];
			var size	:int = s.params[1];
			var sbox:Shape = new Shape();
			
			while (content.numChildren > 0) {
				sbox = content.getChildAt(0) as Shape;
				sbox.graphics.clear();
				content.removeChildAt(0);
			}
			
			for each(var box:Object in boxes){
				sbox = new Shape();
				sbox.x = size * box.x;
				sbox.y = size * box.y;
				sbox.graphics.beginFill(box.color);
				sbox.graphics.drawRect(0, 0, size * box.w, size * box.h);
				content.addChild(sbox);
			}
		}
		
	}

}