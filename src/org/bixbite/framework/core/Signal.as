package org.bixbite.framework.core
{
	import flash.utils.Dictionary;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Signal
	{
		private var list:Dictionary = new Dictionary();
		
		public function Signal()
		{
		
		}
		
		public function add(caller:IActor, callback:Function):void
		{
			list[caller] = callback;
		}
		
		public function remove(caller:IActor):void
		{
			delete list[caller];
		}
		
		public function dispatch(params:IValueObject = null):void
		{
			for each (var f:Function in list) f(params);
		}
		
		public function dispatchTo(target:IActor, params:IValueObject = null):void
		{
			if (list[target]) list[target](params);
		}
	
	}

}