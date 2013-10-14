/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
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
		private var children	:Vector.<IContext> = new Vector.<IContext>();
		private var _parent		:IContext;
		
		private var p			:Point = new Point(0, 0);
		private var _id			:String;
		private var _view		:View;
		private var _body		:Sprite;
		private var _gl			:GraphicsLib;
		
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
		
		public function get parent():IContext 
		{
			return _parent;
		}
		
		public function set parent(value:IContext):void 
		{
			_parent = value;
		}
		
		/*abstract*/ 
		public function init():void {}
		
		/*abstract*/ 
		public function draw():void {}
		
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
			return addChildAt(child, children.length);
		}
		
		public function addChildAt(child:IContext, index:int):IContext
		{
			child.parent = this;
			child.view = this.view;
			_body.addChild(child.body);
			//child.contextAdded();
			children.splice(index, 0, child);
			return child
		}
		
		public function getChildAt(index:int):IContext
		{
			if (index > children.length) RangeError("Index out of range");
			return children[index];
		}
		
		public function removeChild(child:IContext):void 
		{
			removeChildAt(children.indexOf(child));
        }
		
		public function removeChildAt(index:int):void 
		{
			if (index >= children.length) return;
			
			children[index].parent = null;
			children[index].view = null;
			//children[index].contextRemoved();
			children.splice(index, 1)
        }
		
		public function removeChildren():void 
		{
			while(_body.numChildren>0) _body.removeChildAt(0);
		}
		
		public function destroyChildren():void 
		{
			removeChildren();
			
			while (children.length > 0) {
				children[0].destroy();
				children.splice(0, 1);
			}
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
		
		public function destroy():void 
		{
			_gl.clear();
			_gl.ref = null;
			_gl = null;
			
			_body = null;
			_parent = null;
			_view = null;
			
			children = null;
			p = null;
		}
	}

}