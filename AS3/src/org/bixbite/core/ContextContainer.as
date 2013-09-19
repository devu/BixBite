package org.bixbite.core 
{
	import flash.geom.Point;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.interfaces.IContextContainer;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ContextContainer extends Context implements IContextContainer 
	{
		
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
		
		public function getContextUnderPoint(id:String):Context
		{
			var p:Point = new Point(this.mouseX, this.mouseY);
			
			for each(var ctx:Object in getObjectsUnderPoint(p))
				if (ctx is IContext && ctx.id == id) return Context(ctx);
			
			return null
		}
		
	}

}