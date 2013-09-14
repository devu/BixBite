/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework 
{
	
	import org.bixbite.core.Compound;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.behaviour.TriggerKey;
	import org.bixbite.framework.signal.KeySignal;
	import org.bixbite.framework.transponder.KeyboardTransponder;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class KeyboardController extends Compound 
	{
		
		override public function init():void 
		{
			addBehaviour(KeySignal.TRIGGER, TriggerKey);
			
			register(KeyboardTransponder);
		}
		
		override public function destroy():void 
		{
			//clean up this class here and then:
			super.destroy();
		}
		
	}
	
}