/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.starling.view.context 
{
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.View;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class StarlingContext extends Sprite implements IContext
	{
		private var _id				:String;
		private var _parrentView	:View;
		
		public function StarlingContext() 
		{
			var quad:Quad = new Quad(100, 100);
			quad.setVertexColor(0, 0x1c1191);
			quad.setVertexColor(1, 0x1c1191);
			quad.setVertexColor(2, 0xea0b0b);
			quad.setVertexColor(3, 0xea0b0b);
			addChild(quad);
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
		
	}

}