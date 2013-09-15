/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/
package org.bixbite.framework.behaviour 
{
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UIAppInit extends Behaviour 
	{
		
		override public function init():void 
		{
			trace(this, "init");
			
		}
		
		override public function execute(s:Signal):void
		{
			trace(this, "execute");
		}
		
		override public function dispose():void 
		{
			//clean up this class here and then:
			super.dispose();
		}
		
	}
	
}