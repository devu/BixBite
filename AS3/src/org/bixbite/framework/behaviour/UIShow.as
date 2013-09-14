/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UIShow extends Behaviour 
	{
		override public function init():void 
		{
			trace(this, "init");
		}
		
		override public function execute(s:Signal):void 
		{
			trace(this, "execute");
		}
	}

}