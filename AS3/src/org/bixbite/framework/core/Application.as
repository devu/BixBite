package org.bixbite.framework.core 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.framework.core.Observer;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IApplication;
	import org.bixbite.framework.interfaces.IView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 * 
	 * The Application
	 * Is a bond between native stage and View composite structure, also act as TopView. 
	 * This is only because Flash Player nature and requirements.
	 * Document Class must extend DsplayObject.
	 */
	public class Application extends Sprite implements IApplication, IActor
	{
		private var observer:Observer;
		
		public function Application() 
		{
			observer = Observer.instance;
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
			return addChild(child.content);
		}
		
		public function removeView(child:IView):DisplayObject
		{
			return removeChild(child.content);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function, weakKeys:Boolean = false):void
		{
			observer.addSlot(this, type, callback, weakKeys);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			observer.removeSlot(this, type);
		}
		
	}

}