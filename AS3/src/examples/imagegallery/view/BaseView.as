package examples.imagegallery.view 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class BaseView extends View 
	{
		public function BaseView() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			
			addSlot(DisplaySignal.CONTEXT_SET, onContextSet);
			addSlot(DisplaySignal.CONTEXT_ADDED, onContextAdded);
			addSlot(DisplaySignal.CONTEXT_REMOVED, onContextRemoved);
		}
		
		public function createContext(name:String, context:DisplayObject):void
		{
			sendSignal(DisplaySignal.SET_CONTEXT, { name:name, context:context } );
		}
		
		internal function onContextSet(s:Signal):void 
		{
			trace(this, "onContextSet");
		}
		
		internal function onContextAdded(s:Signal):void 
		{
			trace(this, "onContextAdded");
		}
		
		internal function onContextRemoved(s:Signal):void
		{
			trace(this, "onContextRemoved");
		}
		
	}

}