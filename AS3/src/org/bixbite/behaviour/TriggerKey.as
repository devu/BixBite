/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class TriggerKey extends Behaviour 
	{
		
		override public function init():void 
		{
			
		}
		
		override public function execute(s:Signal):void
		{
			var p:Object = s.params;
			emitSignal(p.type, p);
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
	}
	
}