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
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.transponder.UITransponder;
	import org.bixbite.framework.view.UICanvas;
	
	/**
	 * @langversion	3.0
	 * UIManager is an functional module that will provide consistency for building blocks of your application.
	 * By default it will create UICanvas as the root/fundation for any element added into it. 
	 * The adventage of using UIManager is a style provider that is inherited by any children added into display list.
	 * Upon this solution it is possible to achieve great consistency across AS3-Flash and HTML platforms.
	 */
	public class UIManager extends Compound 
	{
		
		public function UIManager() 
		{
			
		}
		
		override public function init():void 
		{
			register(UICanvas);
			register(UITransponder);
			
			addBehaviour(UISignal.CREATE_WINDOW, UICreateWindow);
			addBehaviour(UISignal.OPEN_WINDOW, UIOpenWindow);
			addBehaviour(UISignal.CLOSE_WINDOW, UICloseWindow);
			addBehaviour(UISignal.DESTROY_WINDOW, UIDestroyWindow);
			
			addBehaviour(UISignal.CREATE_PANEL, UICreatePanel);
			addBehaviour(UISignal.DESTROY_PANEL, UICreatePanel);
			
			addBehaviour(UISignal.INIT, UIInitialise, true);
		}
		
	}

}