/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.transponder 
{
	import flash.events.MouseEvent;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.Stats;
	
	/**
	 * @langversion	3.0
     */
	public class StatsTransponder extends Transponder 
	{
		private var root:IContext;
		
		override public function init():void 
		{
			addSlot(Stats.VIEW_READY, onReady);
		}
		
		private function onReady(s:Signal):void
		{
			root = getContext("statsPanel");//TODO get the name of the panel from signal
			root.addSensor(MouseEvent.MOUSE_DOWN, onMouseDown);
			root.addSensor(MouseEvent.MOUSE_UP	, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			root.body.startDrag();
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			root.body.stopDrag();
		}
		
		override public function destroy():void 
		{
			root.removeSensor(MouseEvent.MOUSE_DOWN	, onMouseDown);
			root.removeSensor(MouseEvent.MOUSE_UP	, onMouseUp);
			
			super.destroy();
		}
	}

}