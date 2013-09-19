/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.View;
	
	/**
	 * @langversion	3.0
	 */
	public class Context extends Sprite implements IContext
	{
		private var _id				:String;
		private var _parrentView	:View;
		
		public function Context() 
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
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
		
		public function clone(context:Context):void
		{
			trace(this, 'clone');
		}
		
		/*abstract*/ public function init():void {}
		
		/*abstract*/ public function dispose():void {}
		
	}

}