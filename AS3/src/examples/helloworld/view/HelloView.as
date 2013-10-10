/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.view 
{
	import examples.helloworld.view.context.TextContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	/**
	 * @langversion	3.0
	 * View represents visual layer of our application
	 * It is a bridge between BixBite communication and graphical Context.
	 * Context itself is an abstract form you can extend or reimplement for many purposes.
	 * Notice how both of Views HelloView and Output deals with our TextContext
	 */
	public class HelloView extends View 
	{
		private var ctx:TextContext;
		
		public function HelloView() 
		{
			
		}
		
		override public function init():void 
		{
			ctx = new TextContext();
			ctx.gl.move(200 + Math.random() * 500, 50 + Math.random() * 600);
			
			getContext("app").addChild(ctx);
			
			addSlot("HelloWorld.SET_COPY", onSetCopy);
		}
		
		private function onSetCopy(s:Signal):void 
		{
			applyCopy(s.params.copy);
		}
		
		private function applyCopy(copy:String):void 
		{
			ctx.setHTMLText(copy);
		}
	}

}