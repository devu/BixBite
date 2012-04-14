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
		private var data:Array = [];
		
		public function Trace() 
		{
			
		}
		
		override public function init():void 
		{
			
		}
		
		override public function execute(s:ISignal):void 
		{
			var id:int = s.params.shift();
			var msg:String = s.params.join(" ");
			data[id] = msg;
			
			var info:String = "";
			for (var i:int = 0; i < data.length; i++ ){
				info += data[i] + "\n";
			}
			
			sendSignal(StatsSignal.DISPLAY_TRACE, [info]);
		}
		
	}

}