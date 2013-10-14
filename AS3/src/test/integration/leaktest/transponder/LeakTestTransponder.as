/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.leaktest.transponder 
{
	
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class LeakTestTransponder extends Transponder 
	{
		
		override public function init():void 
		{
			addSlot("LeakTest.INIT", onInit);
		}
		
		private function onInit(s:Signal):void 
		{
			sendSignal("terminate");
		}
		
		override public function destroy():void 
		{
			removeSlot("LeakTest.INIT");
			super.destroy();
		}
		
	}
	
}