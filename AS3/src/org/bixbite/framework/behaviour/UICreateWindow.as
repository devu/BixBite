/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.framework.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.view.UIWindow;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class UICreateWindow extends Behaviour 
	{
		override public function init():void 
		{
			
		}
		
		override public function execute(s:Signal):void
		{
			sendSignalTo(register(UIWindow).uid, UISignal.CREATE, s.params);
		}
	}

}