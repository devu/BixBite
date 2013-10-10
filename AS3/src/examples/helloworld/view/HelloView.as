/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.view 
{
	import examples.helloworld.HelloWorld;
	import org.bixbite.core.Context;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloView extends View 
	{
		private var root	:Context;
		private var tf		:TextField;
		private var ctx		:Context;
		
		public function HelloView() 
		{
			
		}
		
		override public function init():void 
		{
			root = getContext("app");
			ctx = new Context();
			
			tf = new TextField();
			tf.autoSize = "left";
			tf.selectable = false;
			
			ctx.body.addChild(tf);
			ctx.gl.move(200 + Math.random() * 500, 50 + Math.random() * 600);
			
			root.addChild(ctx);
			
			addSlot("HelloWorld.SET_COPY", onSetCopy);
		}
		
		private function onSetCopy(s:Signal):void 
		{
			applyCopy(s.params.copy);
		}
		
		private function applyCopy(copy:String):void 
		{
			tf.htmlText = copy;
		}
	}

}