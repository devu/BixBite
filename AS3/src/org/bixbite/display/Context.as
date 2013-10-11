/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.View;
	import org.bixbite.display.GraphicsLib;
	
	/**
	 * @langversion	3.0
	 */
	public class Context implements IContext
	{
		private var p		:Point = new Point(0, 0);
		private var _id		:String;
		private var _view	:View;
		private var _body	:Sprite;
		private var _gl		:GraphicsLib;
		
		public function Context() 
		{
			_body = new Sprite();
			_gl = new GraphicsLib(_body);
		}
		
		public function get body():* 
		{
			return _body;
		}
		
		public function get id():String 
		{
			return _body.name;
		}
		
		public function set id(value:String):void 
		{
			_body.name = value;
		}
		
		public function get view():View 
		{
			return _view;
		}
		
		public function set view(value:View):void 
		{
			_view = value;
		}
		
		public function get gl():GraphicsLib 
		{
			return _gl;
		}
		
		/*abstract*/ 
		public function init():void {}
		
		/*abstract*/ 
		public function draw():void {}
		
		public function dispose():void 
		{
			gl.clear();
		}
		
		public function addSensor(type:String, callback:Function):void 
		{
			_body.addEventListener(type, callback);
		}
		
		public function removeSensor(type:String, callback:Function):void 
		{
			_body.removeEventListener(type, callback);
		}
		
		public function addChild(child:IContext):IContext 
		{
			_body.addChild(DisplayObject(child.body));
			return child;
		}
		
		public function removeChild(child:IContext):IContext 
		{
			_body.removeChild(child.body);
			return child;
		}
		
		public function removeChildren():void 
		{
			while(_body.numChildren>0) _body.removeChildAt(0);
		}
		
		public function getContextUnderPoint(name:String = null):IContext
		{
			p.x = _body.mouseX;
			p.y = _body.mouseY;
			
			var a:Array = _body.getObjectsUnderPoint(p);
			for each(var ctx:DisplayObject in a){
				if (ctx.name== name) return IContext(this);
			}
			
			return null;
		}
	}

}