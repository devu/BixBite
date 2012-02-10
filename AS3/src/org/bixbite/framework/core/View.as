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
	 * VIEW
	 *
	 * <b>Purpose:</b>
	 * Presents the user interface and the state of the application on the screen
	 * Basic view is also the Leaf View, the final one in the tree structure
	 *
	 * <b>quote</b>
	 * We view things not only from different sides, but with different eyes; we have no wish to find them alike.
	 * — Blaise Pascal
	 *
	 * <b>Implementation:</b>
	 * Abstract class implements Actor as all the MVC objects
	 * Work with Composite pattern and nested views in cooperation with ViewContainer and TopView(Application).
	 * */
	
	public class View extends Actor implements IView
	{
		private var _name:String;
		private var _content:DisplayObject;
		
		public function View()
		{
			if (Object(this).constructor == View)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
		}
		
		//Getters / Setters
		public function get content():DisplayObject { return _content; }
		public function set content(value:DisplayObject):void { _content = value; }
	}

}