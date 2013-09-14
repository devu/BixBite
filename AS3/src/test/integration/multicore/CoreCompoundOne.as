/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.multicore 
{
	
	import org.bixbite.core.Compound;
	import org.bixbite.core.Signal;
	import test.integration.multicore.behaviour.CrossBroadcastTest;
	import test.integration.multicore.behaviour.CrossEmitTest;
	import test.integration.multicore.transponder.CoreOneTransponder;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class CoreCompoundOne extends Compound 
	{
		
		override public function init():void 
		{
			trace(this, "init");
			register(CoreOneTransponder);
			
			addBehaviour("Multicore.crosscore_test", CrossBroadcastTest);
			addBehaviour("emit", CrossEmitTest);
		}
		
		override public function destroy():void 
		{
			//clean up this class here and then:
			super.destroy();
		}
		
	}
	
}