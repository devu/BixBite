package org.bixbite.framework.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.errors.IllegalOperationError;
	import org.bixbite.framework.interfaces.IValueObject;
	import org.bixbite.framework.interfaces.IView;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 *
	 * VIEW CONTAINER
	 *
	 * <b>Purpose:</b>
	 * Extends standard view and act as container for all children views and DisplayObjects
	 * */
	
	public class ViewContainer extends View implements IView
	{
		private var _name:String;
		private var _content:DisplayObjectContainer;
		
		public function ViewContainer()
		{
			if (Object(this).constructor == ViewContainer)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
		}
		
		public function addView(child:IView):IView
		{
			sendSignalTo(child, "addToStage");
			_content.addChild(child.content);
			return child;
		}
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			return _content.addChild(child);
		}
		
		public function removeView(child:IView):IView
		{
			sendSignalTo(child, "removeFromStage");
			_content.removeChild(child.content);
			return child
		}
		
		public function removeChild(child:DisplayObject):DisplayObject
		{
			return _content.removeChild(child);
		}
		
		//Getters / Setters
		override public function set content(value:DisplayObject):void { _content = value as DisplayObjectContainer; }
	}

}