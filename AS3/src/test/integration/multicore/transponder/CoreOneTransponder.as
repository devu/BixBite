/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.multicore.transponder 
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class CoreOneTransponder extends Transponder 
	{
		
		override public function init():void 
		{
			addSensor(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			sendSignal("Multicore.crosscore_test");
		}
		
		override public function destroy():void 
		{
			//clean up this class here and then:
			super.destroy();
		}
		
	}
	
}