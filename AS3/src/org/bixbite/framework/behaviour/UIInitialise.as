/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.UIData;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UIInitialise extends Behaviour 
	{
		override public function init():void 
		{
			addResponder(UISignal.ON_DATA, onData);
		}
		
		override public function execute(s:Signal):void
		{
			sendRequest(UISignal.DATA_REQUEST, s.params);
		}
		
		private function onData(data:UIData):void
		{
			sendSignal(UISignal.INIT, data.style);
		}
	}

}