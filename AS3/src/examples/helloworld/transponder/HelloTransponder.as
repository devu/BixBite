/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.transponder 
{

	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import org.bixbite.core.Transponder;
	
	/**
	 * @langversion	3.0
	 * 
     * This Trasponder will detect if user interact with application
     * If so, will send signal demands to change the copy.
	 * 
     * Trasponder don't care with text field. Although don't care witch and how Behaviour will resolve GET_COPY request.
	 * Transponders deals with user inputs and view changes, it handels interactivity between user,visual state and the rest of application.
	 * Sometimes you don't need to engage any business logic, nor use any data. 
	 * Transponder is your first defence to filter the noise and act only when needed.
	 * This is why Transponder can respond back to views imidietly using responseTo or responseToAll methods.
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
			getContext("app").addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var time:int = getTimer();
			sendSignal("HelloWorld.UPDATE_COPY", { isDefault:false } );
			responseToAll("HelloWorld.TRACE", { trace:"Update copy of 1000 HelloViews "+ (getTimer()-time) } );
		}
		
	}

}