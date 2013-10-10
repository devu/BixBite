/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloflash.transponder 
{
	import examples.helloflash.HelloFlash;
	import flash.events.MouseEvent;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Transponder;
	
	/**
	 * @langversion	3.0
	 */
	public class BallTransponder extends Transponder 
	{
		private var root:IContext;
		
		public function BallTransponder()
		{
			
		}
		
		override public function init():void 
		{
			root = getContext("app"); 
			root.addSensor(MouseEvent.CLICK, onMouseClick);
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			if (root.getContextUnderPoint("ball")) sendSignal(HelloFlash.POKE);
		}
		
	}

}