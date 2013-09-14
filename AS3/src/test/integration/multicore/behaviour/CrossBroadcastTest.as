/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.multicore.behaviour 
{
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class CrossBroadcastTest extends Behaviour 
	{
		
		override public function init():void 
		{
			
		}
		
		override public function execute(s:Signal):void
		{
			trace(this, "on Core A emit signal across all active cores");
			emitSignal("emit", null, true);
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
	}
	
}