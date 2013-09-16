/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.transponder 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.bixbite.core.ContextContainer;
	import org.bixbite.core.Transponder;
	
	
	/**
	 * @langversion	3.0
     */
	public class StatsTransponder extends Transponder 
	{
		private var panel:Sprite;
		private var root:ContextContainer;
		
		override public function init():void 
		{
			root = getContainer("debug");
			
			addSensor(MouseEvent.MOUSE_DOWN	, onMouseDown);
			addSensor(MouseEvent.MOUSE_UP	, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			panel = Sprite(root.getContextUnderPoint("statsPanel"));
			if (panel) panel.startDrag();
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			if (panel) {
				panel.stopDrag();
				panel = null;
			}
		}
		
		override public function destroy():void 
		{
			removeSensor(MouseEvent.MOUSE_DOWN	, onMouseDown);
			removeSensor(MouseEvent.MOUSE_UP	, onMouseUp);
			
			panel = null;
			super.destroy();
		}
	}

}