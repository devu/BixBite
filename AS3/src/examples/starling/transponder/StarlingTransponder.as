/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.starling.transponder 
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class StarlingTransponder extends Transponder 
	{
		private var context:IContext;
		private var miss:int = 0;
		
		override public function init():void 
		{
			addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/**
		 * This is a little demonstration how you can utilise Transponder as a UI logic handler to controll View states
		 * @param	e native event
		 */
		private function onMouseDown(e:Event):void 
		{
			var context:IContext = getContextById("context2D", "stage2D");
			
			if (context) {
				responseTo(context.parrentView.uid, "contextDetected", { text:context.id } );
				miss = 0;
			} else {
				miss++;
				if(miss<3)
					responseToAll("contextNotDetected", { text:"There is no Interactive Context" } );
				else
					responseToAll("destroyContext");
			}
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
	
}