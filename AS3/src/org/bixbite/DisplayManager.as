/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite 
{
	import org.bixbite.core.Compound;
	import org.bixbite.behaviour.DisplayGet;
	import org.bixbite.behaviour.DisplayResize;
	import org.bixbite.behaviour.DisplaySet;
	import org.bixbite.data.DisplayData;
	import org.bixbite.transponder.DisplayTransponder;
	import org.bixbite.signal.Display;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplayManager extends Compound
	{
		
		override public function init():void 
		{
			register(DisplayData);
			register(DisplayTransponder);
			
			addBehaviour(Display.SET_DISPLAY, DisplaySet);
			addBehaviour(Display.GET_DISPLAY, DisplayGet);
			addBehaviour(Display.RESIZE, DisplayResize);
		}
		
		override public function destroy():void 
		{
			removeBehaviour(Display.SET_DISPLAY);
			removeBehaviour(Display.GET_DISPLAY);
			removeBehaviour(Display.RESIZE);
			
			unregister(DisplayData);
			unregister(DisplayTransponder);
			
			super.destroy();
		}
	}

}