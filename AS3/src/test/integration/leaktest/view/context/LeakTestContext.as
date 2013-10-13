/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.leaktest.view.context 
{
	
	import org.bixbite.display.Context;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class LeakTestContext extends Context 
	{
		
		override public function init():void 
		{
			gl.beginFill(0xFF0000, 1);
			gl.drawRect(0, 0, 100, 100);
			gl.move(200, 200);
		}
		
		override public function destroy():void 
		{
			gl.clear();
			super.destroy();
		}
		
	}
	
}