package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.UICloseWindow;
	import org.bixbite.framework.behaviour.UICreateWindow;
	import org.bixbite.framework.behaviour.UIDestroyWindow;
	import org.bixbite.framework.behaviour.UIInitialise;
	import org.bixbite.framework.behaviour.UIOpenWindow;
	import org.bixbite.framework.data.UIData;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.UICanvas;
	
	/**
	 * ...
	 * @author devu
	 */
	public class UIManager extends Compound 
	{
		
		public function UIManager() 
		{
			
		}
		
		override public function init():void 
		{
			register(UIData);
			register(UICanvas);
			
			addBehaviour(UISignal.CREATE_WINDOW, UICreateWindow);
			addBehaviour(UISignal.OPEN_WINDOW, UIOpenWindow);
			addBehaviour(UISignal.CLOSE_WINDOW, UICloseWindow);
			addBehaviour(UISignal.DESTROY_WINDOW, UIDestroyWindow);
			
			addBehaviour(UISignal.INIT, UIInitialise, true, true);
		}
		
	}

}