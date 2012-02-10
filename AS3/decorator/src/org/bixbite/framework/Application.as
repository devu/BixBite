package org.bixbite.framework 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.framework.core.View;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IApplication;
	import org.bixbite.framework.interfaces.IView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Application extends Sprite implements IApplication, IActor
	{
		private var bixbite		:Bixbite;
		
		public function Application() 
		{
			bixbite = Bixbite.instance;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			init();
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			stage.align 	= "TL";
			stage.scaleMode = "noScale";
			
			create();
		}
		
		public function init():void 
		{
			
		}
		
		public function create():void 
		{
			
		}
		
		public function addView(child:IView):DisplayObject 
		{
			bixbite.sendSignalTo(child, "addToStage");
			return addChild(child.content);
		}
		
		public function removeView(child:IView):DisplayObject
		{
			bixbite.sendSignalTo(child, "removeFromStage");
			return removeChild(child.content);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function, weakKeys:Boolean = false):void
		{
			bixbite.addSlot(this, type, callback, weakKeys);
		}
		
	}

}