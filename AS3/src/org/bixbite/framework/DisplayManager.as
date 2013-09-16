/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.DisplayGet;
	import org.bixbite.framework.behaviour.DisplayResize;
	import org.bixbite.framework.behaviour.DisplaySet;
	import org.bixbite.framework.data.DisplayData;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.transponder.DisplayTransponder;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplayManager extends Compound
	{
		//internals
		static public const DATA_REQUEST			:String = "DisplayManager.DATA_REQUEST";
		static public const RESIZE					:String = "DisplayManager.RESIZE";
		
		override public function init():void 
		{
			register(DisplayData);
			register(DisplayTransponder);
			
			addBehaviour(DisplaySignal.SET_DISPLAY, DisplaySet);
			addBehaviour(DisplaySignal.GET_DISPLAY, DisplayGet);
			addBehaviour(DisplayManager.RESIZE, DisplayResize);
		}
		
		override public function destroy():void 
		{
			removeBehaviour(DisplaySignal.SET_DISPLAY);
			removeBehaviour(DisplayManager.RESIZE);
			
			unregister(DisplayData);
			unregister(DisplayTransponder);
			
			super.destroy();
		}
	}

}