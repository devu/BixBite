/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.transponder 
{
	
	import org.bixbite.core.Transponder;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UITransponder extends Transponder 
	{
		
		override public function init():void 
		{
			trace(this, "init");
		}
		
		override public function destroy():void 
		{
			//clean up this class here and then:
			super.destroy();
		}
		
	}
	
}