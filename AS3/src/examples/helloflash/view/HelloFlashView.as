/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.view 
{
	import examples.helloflash.HelloFlash;
	import examples.helloflash.view.context.HelloFlashOutput;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloFlashView extends View 
	{
		private var root	:IContext;
		private var output	:HelloFlashOutput;
		
		override public function init():void 
		{
			root = getContext("app");
			
			output = HelloFlashOutput(registerContext("HelloFlashOutput", new HelloFlashOutput()));
			output.gl.move(100, 100);
			
			root.addChild(output);
			
			addSlot(HelloFlash.CREATE_BALL, onCreateBall);
		}
		
		private function onCreateBall(s:Signal):void
		{
			output.text = "Click count:" + s.params;
		}
		
	}

}