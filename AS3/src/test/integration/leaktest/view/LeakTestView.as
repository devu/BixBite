/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.leaktest.view 
{
	
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import test.integration.leaktest.view.context.LeakTestContext;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class LeakTestView extends View 
	{
		
		override public function init():void 
		{
			addSlot("LeakTest.INIT", onInit);
			getContext("app").addChild(new LeakTestContext());
		}
		
		private function onInit(s:Signal):void 
		{
			sendSignal("init");
		}
		
		override public function destroy():void 
		{
			removeSlot("LeakTest.INIT");
			getContext("app").destroyChildren();
			
			super.destroy();
		}
		
	}
	
}