package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.CreateWindowApplication;
	import org.bixbite.framework.data.AppData;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.AppWindow;
	/**
	 * ...
	 * @author devu
	 */
	public class Application extends Compound 
	{
		override public function init():void 
		{
			register(AppData);
			register(AppWindow);
			
			addBehaviour(UISignal.INIT, CreateWindowApplication);
		}
	}

}