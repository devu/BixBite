/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.coreperf.view 
{
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import test.performance.coreperf.view.context.TestViewBContext;
	
	/**
	 * @langversion	3.0
	 */
	public class TestViewB extends View 
	{
		
		public function TestViewB() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot("testSignalB", onTestSignalB);
			getContext("app").addChild(new TestViewBContext());
		}
		
		private function onTestSignalB(s:Signal):void 
		{
			
		}
		
		override public function destroy():void 
		{
			getContext("app").removeChildren();
			removeSlot("testSignalB");
			super.destroy();
		}
		
	}

}