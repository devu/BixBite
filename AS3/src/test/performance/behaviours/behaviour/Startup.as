package test.performance.behaviours.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	import test.performance.behaviours.Signals;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Startup extends Behaviour 
	{
		
		public function Startup() 
		{
			
		}
		
		override public function execute(s:ISignal):void 
		{
			sendSignal(Signals.REPOSITION);
			sendSignal(Signals.CHANGE_COLOR, [0x000000]);
		}
		
	}

}