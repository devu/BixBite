package org.bixbite.framework.core 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import org.bixbite.framework.Bixbite;
	import org.bixbite.framework.interfaces.IActor;
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
	
	public class View extends Actor implements IView
	{
		private var bixbite			:Bixbite;
		
		private var _name			:String;
		private var _content		:DisplayObjectContainer;
		
		public function View(content:DisplayObjectContainer = null) 
		{
			if (Object(this).constructor == View)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
				
			bixbite = Bixbite.instance;
			
			_content = (content) ? content : new Sprite();
			
			addSlot("addToStage", addedToStage);
			addSlot("removeFromStage", removedFromStage);
		}
		
		private function addedToStage(s:IValueObject):void 
		{
			removeSlot("addToStage");
			create();
		}
		
		private function removedFromStage(s:IValueObject):void 
		{
			removeSlot("removeFromStage");
			destroy();
		}
		
		public function addView(child:IView):DisplayObject
		{
			bixbite.sendSignalTo(child, "addToStage");
			return content.addChild(child.content);
		}
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			return content.addChild(child);
		}
		
		public function removeView(child:IView):DisplayObject
		{
			bixbite.sendSignalTo(child, "removeFromStage");
			return content.removeChild(child.content);
		}
		
		public function removeChild(child:DisplayObject):DisplayObject
		{
			return content.removeChild(child);
		}
		
		//abstract methods
		public function create():void {}
		public function destroy():void {}
		
		public function get content():DisplayObjectContainer { return _content; }
		public function set content(value:DisplayObjectContainer):void { _content = value; }
	}

}