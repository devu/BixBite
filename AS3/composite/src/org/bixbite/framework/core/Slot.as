package org.bixbite.framework.core
{
	import flash.utils.Dictionary;
	import org.bixbite.framework.interfaces.IActor;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Slot extends Dictionary
	{
		public function Slot(weakKeys:Boolean = false)
		{
			super(weakKeys);
		}
		
		public function add(caller:IActor, callback:Function):void
		{
			this[caller] = callback;
		}
		
		public function remove(caller:IActor):void
		{
			delete this[caller];
		}
		
		public function dispatch(params:IValueObject = null):void
		{
			for each (var f:Function in this) f(params);
		}
		
		public function dispatchTo(target:IActor, params:IValueObject = null):void
		{
			if (this[target]) this[target](params);
		}
	
	}

}