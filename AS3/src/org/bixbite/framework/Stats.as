/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.StatsCalculate;
	import org.bixbite.framework.data.StatsData;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.transponder.StatsTransponder;
	import org.bixbite.framework.view.StatsMonitorView;
	
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