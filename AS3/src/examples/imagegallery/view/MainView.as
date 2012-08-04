package examples.imagegallery.view 
{
	import flash.display.Sprite;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MainView extends BaseView 
	{
		private var mainViewContext:Sprite;
		
		public function MainView() 
		{
			
		}
		
		override public function init():void 
		{
			super.init();
			
			mainViewContext = new Sprite();
			createContext("mainView", mainViewContext);
		}
		
		override internal function onContextSet(s:Signal):void 
		{
			trace(this, "onContextSet");
			
			mainViewContext.graphics.clear();
			mainViewContext.graphics.beginFill(0xFF0000, 1);
			mainViewContext.graphics.drawRect(0, 0, 200, 200);
		}
		
		override internal function onContextAdded(s:Signal):void 
		{
			trace(this, "onContextAdded");
			//sendSignal(DisplaySignal.REMOVE_CONTEXT, { name:"mainView" } );
		}
		
		override internal function onContextRemoved(s:Signal):void 
		{
			trace(this, "onContextRemoved");
		}
	}

}