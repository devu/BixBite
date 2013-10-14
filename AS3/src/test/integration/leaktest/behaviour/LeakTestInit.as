/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.leaktest.behaviour 
{
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import test.integration.leaktest.data.LeakTestData;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class LeakTestInit extends Behaviour 
	{
		private var data:LeakTestData;
		
		override public function init():void 
		{
			addResponder("LeakTest.DATA_REQUEST", onData, true);
		}
		
		private function onData(data:LeakTestData):void 
		{
			this.data = data;
		}
		
		override public function execute(s:Signal):void 
		{
			sendSignal("LeakTest.INIT");
		}
		
		override public function destroy():void 
		{
			this.data = null;
			removeResponder("LeakTest.DATA_REQUEST");
			
			super.destroy();
		}
		
	}
	
}