/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.leaktest.behaviour 
{
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import test.integration.leaktest.LeakTest;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class LeakTestTerminate extends Behaviour 
	{
		
		override public function init():void 
		{
			
		}
		
		override public function execute(s:Signal):void 
		{
			
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
	
}