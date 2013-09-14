/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.starling 
{
	
	import examples.starling.transponder.StarlingTransponder;
	import examples.starling.view.StarlingTestView;
	import org.bixbite.core.Compound;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class HelloStarling extends Compound 
	{
		
		override public function init():void 
		{
			register(StarlingTestView);
			register(StarlingTransponder);
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
	
}