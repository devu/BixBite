package org.bixbite.core 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.interfaces.IContextContainer;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ContextContainer extends Context implements IContextContainer 
	{
		public function ContextContainer() 
		{
			
		}
		
		public function add(child:Context):Context 
		{
			addChild(child);
			return child;
		}
		
		public function remove(child:Context):Context 
		{
			removeChild(child);
			return child;
		}
		/*
		public function getContext(id:String):Context
		{
			return getChildByName(id);
		}*/
		
		public function getContextUnderPoint(id:String):Context
		{
			var p:Point = new Point(this.mouseX, this.mouseY);
			
			for each(var ctx:Object in getObjectsUnderPoint(p)){
				//trace(ctx.id);
				if (ctx is IContext && ctx.id == id) return Context(ctx);
			}
			
			return null
		}
		
	}

}