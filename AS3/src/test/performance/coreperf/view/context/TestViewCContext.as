/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.coreperf.view.context 
{
	import org.bixbite.framework.view.Context;
	
	/**
	 * @langversion	3.0
	 */
	public class TestViewCContext extends Context 
	{
		
		public function TestViewCContext() 
		{
			graphics.beginFill(0x000FFF, 1);
			graphics.drawRect(0, 0, 100, 100);
		}
		
		override public function dispose():void 
		{
			graphics.clear();
		}
		
	}

}