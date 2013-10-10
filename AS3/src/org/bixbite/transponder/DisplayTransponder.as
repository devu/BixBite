/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.transponder 
{
	import org.bixbite.core.Transponder;
	import org.bixbite.signal.Display;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplayTransponder extends Transponder 
	{
		override public function init():void
		{
			transmit(Display.GET_DISPLAY);
		}
		
		override public function destroy():void 
		{
			removeSlot(Display.GET_DISPLAY);
			super.destroy();
		}
	}

}