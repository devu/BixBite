/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.leaktest.data 
{
	
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class LeakTestData extends Data 
	{
		
		override public function init():void 
		{
			addSlot("LeakTest.DATA_REQUEST", onDataRequest);
		}
		
		private function onDataRequest(s:Signal):void 
		{
			responseToAll("LeakTest.DATA_REQUEST");
		}
		
		override public function destroy():void 
		{
			removeSlot("getData");
			super.destroy();
		}
		
	}
	
}