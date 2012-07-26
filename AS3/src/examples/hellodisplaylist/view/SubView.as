package examples.hellodisplaylist.view 
{
	import flash.display.Sprite;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class SubView extends View 
	{
		private var context				:Sprite;
		
		public function SubView() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(DisplaySignal.CONTEXT_SET		, onContextSet);
			addSlot(DisplaySignal.CONTEXT_ADDED		, onContextAdded);
			addSlot(DisplaySignal.CONTEXT_REMOVED	, onContextRemoved);
			
			// create
			context = new Sprite();
			// register it
			sendSignal(DisplaySignal.SET_CONTEXT, { name:"subView", context:context } );
			// add
			sendSignal(DisplaySignal.ADD_CONTEXT, { name:"subView", container:"mainView" } );
		}
		
		private function onContextSet(s:Signal):void
		{
			trace("context of", this, "has been set with a name", s.params.name, "and unique id:", s.params.contextUID );
			
			context.x = 10;
			context.y = 10;
			
			// Yes you right, context is not on the stage, however is available even here
			trace(stage);
		}
		
		private function onContextAdded(s:Signal):void 
		{
			trace("context of", this, "has been added to", s.params.container);
			
			context.graphics.beginFill(0x000066);
			context.graphics.drawRect(0, 0, 60, 60);
		}
		
		private function onContextRemoved(s:Signal):void 
		{
			trace("context of", this, "has been removed from", s.params.container);
			
			context.graphics.clear();
		}
		
		override public function destroy():void 
		{
			
			super.destroy();
		}
		
	}

}