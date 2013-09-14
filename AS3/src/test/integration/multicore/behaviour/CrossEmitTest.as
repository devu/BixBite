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
	public class CrossEmitTest extends Behaviour 
	{
		override public function execute(s:Signal):void
		{
			//this Behaviour has been registered within 2 separate cores, when executed it should trace on both
			trace(this, "ecexuted", this.uid);
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
	}
	
}