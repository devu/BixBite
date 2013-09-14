/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.data 
{
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.Stats;
	
	/**
	 * @langversion	3.0
	 */
	public class StatsData extends Data 
	{
		public var mem				:Number = 0;
		public var max				:Number = 0;
		public var fps				:Number = 0;
		
		public var timer			:int;
		public var ms				:int;
		
		public var frameRate		:Number;
		
		public var infoFPS			:String;
		public var infoMEM			:String;
		public var infoMAX			:String;
		public var infoMS			:String;
		
		override public function init():void
		{
			frameRate = stage.frameRate;
			
			addSlot(Stats.DATA_REQUEST, onDataRequest);
		}
		
		private function onDataRequest(s:Signal):void
		{
			responseTo(s.callerUID, Stats.DATA_REQUEST);
			removeSlot(Stats.DATA_REQUEST);
		}
		
		override public function destroy():void 
		{
			removeSlot(Stats.DATA_REQUEST);
			
			super.destroy();
		}
		
	}

}