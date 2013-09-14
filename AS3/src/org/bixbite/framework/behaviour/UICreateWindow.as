package org.bixbite.framework.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.UIData;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @author devu
	 */
	public class UICreateWindow extends Behaviour 
	{
		override public function init():void 
		{
			trace(this, "init");
			addResponder(UISignal.ON_DATA, onData);
		}
		
		private function onData(data:UIData):void
		{
			trace(this, "onData Response");
		}
		
		override public function execute(s:Signal):void
		{
			trace(this, "execute");
		}
	}

}