package org.bixbite.framework.view.context
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.View;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Context extends Sprite implements IContext
	{
		private var _id				:String;
		private var _parrentView	:View;
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get parrentView():View 
		{
			return _parrentView;
		}
		
		public function set parrentView(value:View):void 
		{
			_parrentView = value;
		}
		
		/*abstract*/
		public function init():void
		{
			
		}
		
		/*abstract*/
		public function draw():void
		{
			
		}
		
		/*abstract*/ 
		public function dispose():void
		{
			
		}
		
	}

}