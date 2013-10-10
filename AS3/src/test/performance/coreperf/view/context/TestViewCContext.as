/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.coreperf.view.context 
{
	import org.bixbite.display.Context;
	
	/**
	 * @langversion	3.0
	 */
	public class TestViewCContext extends Context 
	{
		
		public function TestViewCContext() 
		{
			
		}
		
		override public function init():void 
		{
			gl.beginFill(0x000FFF, 1);
			gl.drawRect(0, 0, 100, 100);
		}
		
		override public function dispose():void 
		{
			gl.clear();
		}
		
	}

}