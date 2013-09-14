/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.data 
{
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UIData extends Data 
	{
		public var style:UIStyle;
		
		public function UIData() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			style = new UIStyle();
			addSlot(UISignal.DATA_REQUEST, onDataRequest);
		}
		
		private function onDataRequest(s:Signal):void 
		{
			if (s.params){
				if (s.params.style != null)
					style = s.params.style;
			}
			
			
			responseToAll(UISignal.ON_DATA);
		}
		
	}

}