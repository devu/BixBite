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
	 * ...
	 * @langversion 3.0
	 * Simplest possible way of dealing with context
	 * Just create new instance of it and you can add it as a child to the container
	 * getContext method is your friend. Views are abstract, they don't know anything about Flash or its stage.
	 * It is implemented within IDisplay allowes us to implement it many diferent ways, you can hook up Straling, 
	 * any Stage3D, Blitt or custom DisplayList lib/framework. By default we using a wrapper for NativeDisplayList
	 */
	public class Output extends View 
	{
		private var ctx:TextContext;
		
		override public function init():void 
		{
			
			ctx = new TextContext();
			getContext("app").addChild(ctx);
			
			addSlot("HelloWorld.TRACE", onTrace);
		}
		
		private function onTrace(s:Signal):void 
		{
			ctx.setText(s.params.trace);
		}
		
	}
	
}