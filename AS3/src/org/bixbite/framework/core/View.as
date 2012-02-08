package org.bixbite.framework.core 
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	import org.bixbite.framework.Bixbite;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IGraphicsFactory;
	import org.bixbite.framework.interfaces.IValueObject;
	import org.bixbite.framework.interfaces.IView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 * 
	 * VIEW
	 * 
	 * <b>Purpose:</b>
	 * Presents the user interface and the state of the application on screen
	 * 
	 * <b>quote</b>
	 * We view things not only from different sides, but with different eyes; we have no wish to find them alike.
	 * — Blaise Pascal
	 * 
	 * <b>Implementation:</b>
	 * Abstract class implements Actor as all the MVC objects
	 * However to addition to that directly extends Sprite to become Flash Display List firendly solution, 
	 * Work with Composite pattern and nested views without clash.
	 * Furthermore making things easier to work with in very systematic manier. Following Template Pattern will provides and executes set of abstract methods so you don't have to repeat yourself all the time.
	 * */
	
	public class View extends Sprite implements IActor, IView
	{
		private var bixbite			:Bixbite;
		
		private var _name			:String;
		
		public function View() 
		{
			this.mouseEnabled = false;
			
			if (Object(this).constructor == View)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
				
			bixbite = Bixbite.instance;
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			init();
		}
		
		private function addedToStage(e:Event):void 
		{
			create();
		}
		
		private function removedFromStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			destroy();
		}
		
		//abstract methods
		public function init():void {}
		public function create():void {}
		public function destroy():void {}
		
		//signal mechanism
		
		/**
		 * 
		 * @param	type
		 * @param	callback
		 */
		public function attachSignal(type:String, callback:Function):void
		{
			bixbite.attachSignal(this, type, callback);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function detachSignal(type:String):void
		{
			bixbite.detachSignal(this, type);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):void
		{
			bixbite.sendSignal(type, params);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):void
		{
			bixbite.sendSignalTo(target, type, params);
		}
		
		//read only
		public function get gl():IGraphicsFactory { return bixbite.gl; }
		
	}

}