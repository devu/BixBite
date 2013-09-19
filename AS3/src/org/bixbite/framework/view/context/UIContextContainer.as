package org.bixbite.framework.view.context 
{
	import org.bixbite.core.Context;
	import org.bixbite.core.ContextContainer;
	import org.bixbite.framework.data.vo.UIStyle;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class UIContextContainer extends ContextContainer 
	{
		public var color		:uint  = 0x929292;
		public var opacity		:Number = 1;
		public var border		:Number = 1;
		public var borderColor	:uint  = 0x000000;
		public var margin		:Array = [0,0,0,0];
		
		private var w:Number = 100;
		private var h:Number = 100;
		
		public function UIContextContainer() 
		{
			
		}
		
		public function setPosition(x:Number, y:Number):void 
		{
			this.x = x;
			this.y = y;
		}
		
		public function setSize(width:Number, height:Number):void 
		{
			this.width = width;
			this.height = height;
		}
		
		override public function get width():Number 
		{
			return w;
		}
		
		override public function set width(value:Number):void 
		{
			this.w = value;
		}
		
		override public function get height():Number 
		{
			return h;
		}
		
		override public function set height(value:Number):void 
		{
			this.h = value;
		}
		
		public function draw():void
		{
			
		}
		
		override public function clone(context:Context):void 
		{
			var ctx:UIContextContainer;
			if (context is UIContextContainer){
				ctx = UIContextContainer(context);
				this.color = ctx.color;
				this.border = ctx.border;
				this.margin = ctx.margin;
			}
			
		}
		
	}

}