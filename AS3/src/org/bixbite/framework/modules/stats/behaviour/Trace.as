package org.bixbite.framework.modules.stats.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.signals.StatsSignal;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Trace extends Behaviour 
	{
		
		public function Trace() 
		{
			
		}
		
		override public function init():void 
		{
			
		}
		
		override public function execute(s:ISignal):void 
		{
			var info:String = s.params.join(",") + "\n";
			sendSignal(StatsSignal.DISPLAY_TRACE, [info]);
		}
		
	}

}