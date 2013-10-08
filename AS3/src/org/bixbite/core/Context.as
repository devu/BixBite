/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core
{
	import flash.display.Sprite;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.View;
	import org.bixbite.display.GraphicsLib;
	import org.bixbite.display.IDisplayList;
	
	/**
	 * @langversion	3.0
	 */
	public class Context implements IContext, IDisplayList
	{
		private var _id		:String;
		private var _view	:View;
		private var _body	:*;
		
		public var gl		:GraphicsLib;
		
		public function Context() 
		{
			_body = new Sprite();
			gl = new GraphicsLib(_body);
		}
		
		public function get body():* 
		{
			return _body;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get view():View 
		{
			return _view;
		}
		
		public function set view(value:View):void 
		{
			_view = value;
		}
		
		/*abstract*/ 
		public function init():void {}
		
		/*abstract*/ 
		public function draw():void {}
		
		public function dispose():void 
		{
			gl.clear();
			
			while (_body.numChildren > 0) _body.removeChildAt(0);
			_body.clear();
			_body.parent.removeChild(_body);
		}
		
		public function addSensor(type:String, callback:Function):void 
		{
			body.addEventListener(type, callback);
		}
		
		public function removeSensor(type:String, callback:Function):void 
		{
			body.removeEventListener(type, callback);
		}
		
		public function addChild(child:Context):Context 
		{
			this.body.addChild(child.body);
			return child;
		}
		
		public function removeChild(child:Context):Context 
		{
			this.body.removeChild(child.body);
			return child;
		}
	}

}