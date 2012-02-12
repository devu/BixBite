package org.bixbite.framework.core 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.framework.core.Observer;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IValueObject;
	import org.bixbite.framework.interfaces.IView;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 * 
	 * The Application
	 * Is a bond between native stage and View composite structure, also act as TopView. 
	 * This is only because Flash Player nature and requirements.
	 * Document Class must extend DsplayObject.
	 */
	public class Application extends Sprite implements IActor
	{
		private var observer	:Observer;
		private var _uid		:int;
		
		public function Application() 
		{
			observer = Observer.instance;
			_uid = observer.BIXBITE::getUID();
			
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
		
		public function addView(child:IView):IView 
		{
			addChild(child.content);
			return child;
		}
		
		public function removeView(child:IView):IView
		{
			removeChild(child.content)
			return child;
		}
		
		/**
		 * 
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function, weakKeys:Boolean = false):void
		{
			observer.BIXBITE::addSlot(_uid, type, callback, weakKeys);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			observer.BIXBITE::removeSlot(_uid, type);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function destroySlot(type:String):void
		{
			observer.BIXBITE::destroySlot(type);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):Array
		{
			return observer.BIXBITE::sendSignal(type, params);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):Function
		{
			return observer.BIXBITE::sendSignalTo(target.uid, type, params);
		}
		
		public function get uid():int 
		{
			return _uid;
		}
		
	}

}