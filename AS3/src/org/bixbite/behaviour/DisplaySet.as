/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.signal.Display;
	
	/**
	 * @langversion	3.0
	 */
	public class DisplaySet extends Behaviour 
	{
		
		override public function execute(s:Signal):void
		{
			var params:Object = { root:null, align:"TL", scaleMode:"noScale", frameRate:30 };
			
			if (s.params)
				for (var p:String in s.params) params[p] = s.params[p];
			
			sendRequest(Display.SET_DISPLAY, params);
		}
		
	}

}