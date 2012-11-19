package test.integration.multicore 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	import org.bixbite.framework.Stats;
	import test.performance.coreperf.CorePerformance;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MainMulticore extends Sprite 
	{
		private var core1:Core;
		private var core2:Core;
		private var core3:Core;
		
		public function MainMulticore() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var bb:BixBite = new BixBite(stage);
			
			core1 = bb.spawnCore("1");
			core1.register(StageManager);
			core1.sendSignal(StageSignal.SET_STAGE, { frameRate:30 } );
			core1.register(Stats);
			core1.sendSignal(Stats.START);
			core1.register(CoreCompoundOne);
			
			core2 = bb.spawnCore("2");
			core2.register(CorePerformance);
			core2.register(CoreCompoundTwo);
			
			core3 = bb.spawnCore("3");
			core3.register(Stats);
			core3.sendSignal(Stats.START);
		}
	}

}