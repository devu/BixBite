/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplaySet extends Behaviour 
	{
		
		override public function execute(s:Signal):void
		{
			var params:Object = { align:"TL", scaleMode:"noScale", frameRate:30 };
			
			if (s.params)
				for (var p:String in s.params) params[p] = s.params[p];
			
			sendRequest(DisplaySignal.SET_DISPLAY, params);
		}
		
	}

}