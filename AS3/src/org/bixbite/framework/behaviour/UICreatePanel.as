/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.behaviour 
{
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.UIPanel;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UICreatePanel extends Behaviour 
	{
		override public function init():void 
		{
			
		}
		
		override public function execute(s:Signal):void
		{
			sendSignalTo(register(UIPanel, false).uid, UISignal.CREATE, s.params);
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
	}
	
}