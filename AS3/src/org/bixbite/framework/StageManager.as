/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.ResizeStage;
	import org.bixbite.framework.behaviour.SetStage;
	import org.bixbite.framework.data.StageData;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.transponder.StageTransponder;
	
	/**
	 * @langversion	3.0
	 */
	public class StageManager extends Compound
	{
		//internals
		static public const DATA_REQUEST			:String = "StageManager.DATA_REQUEST";
		static public const RESIZE					:String = "StageManager.RESIZE";
		
		override public function init():void 
		{
			register(StageData);
			register(StageTransponder);
			
			addBehaviour(StageSignal.SET_STAGE, SetStage);
			addBehaviour(StageManager.RESIZE, ResizeStage);
		}
		
		override public function destroy():void 
		{
			removeBehaviour(StageSignal.SET_STAGE);
			removeBehaviour(StageManager.RESIZE);
			
			unregister(StageData);
			unregister(StageTransponder);
			
			super.destroy();
		}
	}

}