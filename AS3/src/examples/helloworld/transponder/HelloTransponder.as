/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.transponder 
{

	import examples.helloworld.HelloWorld;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	
	/**
	 * @langversion	3.0
	 * 
     * This Trasponder will detect if any text field has been clicked.
     * If so, will send signal demands to change the copy.
     * Trasponder don't care with text field. Although don't care witch and how Atom will resolve GET_COPY request.
     */
	public class HelloTransponder extends Transponder 
	{
		
		public function HelloTransponder() 
		{
			
		}
		
		/**
		 * Add system listener to capture user Input by adding sensors.
		 */
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var time:int = getTimer();
			sendSignal("HelloWorld.UPDATE_COPY", { isDefault:false } );
			responseToAll("Trace", { trace:"Update copy of 1000 HelloViews "+ (getTimer()-time) } );
		}
		
	}

}