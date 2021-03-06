/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite 
{
	import org.bixbite.behaviour.StatsCalculate;
	import org.bixbite.core.Compound;
	import org.bixbite.data.StatsData;
	import org.bixbite.transponder.StatsTransponder;
	import org.bixbite.view.StatsMonitorView;
	
	/**
	 * @langversion	3.0
	 * 
	 * This is fork of stats by mrdoob implemented within BixBite framework.
	 * 
	 */
	public class Stats extends Compound 
	{
		//internals
		static public const DATA_REQUEST	:String = "Stats.DATA_REQUEST";
		static public const UPDATE			:String = "Stats.UPDATE";
		static public const UPDATE_REALTIME	:String = "Stats.UPDATE_REALTIME";
		
		//in
		static public const START			:String = "Stats.START";
		static public const VIEW_READY		:String = "Stats.VIEW_READY";
		
		override public function init():void 
		{
			register(StatsData);
			register(StatsTransponder);
			register(StatsMonitorView);
			
			addBehaviour(Stats.START, StatsCalculate);
		}
		
		override public function destroy():void 
		{
			removeBehaviour(Stats.START);
			
			unregister(StatsData);
			unregister(StatsTransponder);
			unregister(StatsMonitorView);
			
			super.destroy();
		}
	}

}