/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.UICloseWindow;
	import org.bixbite.framework.behaviour.UICreatePanel;
	import org.bixbite.framework.behaviour.UICreateWindow;
	import org.bixbite.framework.behaviour.UIDestroyWindow;
	import org.bixbite.framework.behaviour.UIInitialise;
	import org.bixbite.framework.behaviour.UIOpenWindow;
	import org.bixbite.framework.data.UIData;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.transponder.UITransponder;
	import org.bixbite.framework.view.UICanvas;
	
	/**
	 * @langversion	3.0
	 */
	public class UIManager extends Compound 
	{
		
		public function UIManager() 
		{
			
		}
		
		override public function init():void 
		{
			register(UIData);
			register(UITransponder);
			register(UICanvas);
			
			addBehaviour(UISignal.CREATE_WINDOW, UICreateWindow);
			addBehaviour(UISignal.OPEN_WINDOW, UIOpenWindow);
			addBehaviour(UISignal.CLOSE_WINDOW, UICloseWindow);
			addBehaviour(UISignal.DESTROY_WINDOW, UIDestroyWindow);
			
			addBehaviour(UISignal.CREATE_PANEL, UICreatePanel);
			
			addBehaviour(UISignal.INIT, UIInitialise, true);
		}
		
	}

}