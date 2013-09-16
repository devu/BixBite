/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.view 
{
	import examples.helloflash.HelloFlash;
	import examples.helloflash.view.context.HelloFlashOutput;
	import org.bixbite.core.ContextContainer;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloFlashView extends View 
	{
		private var root	:ContextContainer;
		private var output	:HelloFlashOutput;
		
		override public function init():void 
		{
			root = getContainer("app");
			
			output = HelloFlashOutput(registerContext("HelloFlashOutput", HelloFlashOutput));
			output.x = 100;
			output.y = 100;
			
			root.add(output);
			
			addSlot(HelloFlash.CREATE_BALL, onCreateBall);
		}
		
		private function onCreateBall(s:Signal):void
		{
			output.text = "Click count:" + s.params;
		}
		
	}

}