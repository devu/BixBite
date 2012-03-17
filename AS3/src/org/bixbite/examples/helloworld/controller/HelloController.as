package org.bixbite.examples.helloworld.controller 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import org.bixbite.core.Controller;
	
	/**
     * This Controller will detect if your text field has been clicked.
     * If so, will send signal demands to change the copy.
     * Controller don't care with text field. Although don't care witch and how Model will resolve replaceCopy request.
     * It can be any or many of them at the same time.
     */
	public class HelloController extends Controller 
	{
		
		public function HelloController() 
		{
			
		}
		
		/**
		 * Add system listener to capture user Input.
		 */
		override public function init():void 
		{
			system.addListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var objects:Array = system.getObjects();
			
			for each(var o:Object in objects){
				if (o is TextField) {
					var tf:TextField = o as TextField;
					tf.mouseEnabled = false;
					tf.textColor = 0xFF0000;
					sendSignal("replaceCopy");
				}
			}
		}
		
	}

}