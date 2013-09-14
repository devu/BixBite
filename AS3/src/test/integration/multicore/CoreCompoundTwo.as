/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.multicore 
{
	
	import org.bixbite.core.Compound;
	import org.bixbite.core.Signal;
	import test.integration.multicore.behaviour.CrossEmitTest;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class CoreCompoundTwo extends Compound 
	{
		
		override public function init():void 
		{
			trace(this, "init");
			
			addBehaviour("emit", CrossEmitTest);
		}
		
		override public function destroy():void 
		{
			//clean up this class here and then:
			super.destroy();
		}
		
	}
	
}