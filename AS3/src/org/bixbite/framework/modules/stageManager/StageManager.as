package org.bixbite.framework.modules.stageManager 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.stageManager.behaviour.StageResize;
	import org.bixbite.framework.modules.stageManager.data.StageData;
	import org.bixbite.framework.modules.stageManager.transponder.StageTransponder;
	import org.bixbite.framework.signals.StageSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class StageManager extends Compound 
	{
		
		public function StageManager(stage:Stage = null, align:String = "TL", scaleMode:String = "noScale") 
		{
			stage = (!this.stage) ? stage : this.stage;
			stage.scaleMode = scaleMode;
			stage.align = align;
			
			var d:StageData 		= new StageData(stage);
			var t:StageTransponder 	= new StageTransponder();
			
			addBehaviour(StageSignal.RESIZE, StageResize);
		}
		
		private function onResize(e:Event):void 
		{
			trace("resize");
		}
		
	}

}