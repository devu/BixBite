/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.userinterface 
{
	
	import org.bixbite.core.Compound;
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class HelloUIApp extends Compound 
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