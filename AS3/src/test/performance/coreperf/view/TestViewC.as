/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.coreperf.view 
{
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import test.performance.coreperf.view.context.TestViewCContext;
	
	/**
	 * @langversion	3.0
	 */
	public class TestViewC extends View 
	{
		
		public function TestViewC() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("testSignalC", onTestSignalC);
			getContext("app").addChild(new TestViewCContext());
		}
		
		private function onTestSignalC(s:Signal):void 
		{
			
		}
		
		override public function destroy():void 
		{
			getContext("app").removeChildren();
			removeSlot("testSignalC");
			super.destroy();
		}
		
	}

}