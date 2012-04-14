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
		private var msg:Array = [];
		
		public function Trace() 
		{
			
		}
		
		override public function init():void 
		{
			
		}
		
		override public function execute(s:ISignal):void 
		{
			var id:int = s.params.shift();
			msg[id] = s.params.join(" ");
			
			var info:String = "";
			for (var i:int = 0; i < msg.length; i++ ){
				info += msg[i] + "\n";
			}
			
			sendSignal(StatsSignal.DISPLAY_TRACE, [info]);
		}
		
	}

}