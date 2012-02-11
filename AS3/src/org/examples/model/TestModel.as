package org.examples.model 
{
	import org.bixbite.framework.core.Model;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestModel extends Model 
	{
		
		public function TestModel() 
		{
			
		}
		
		override public function init():void
		{
			//still not so sure about addSignal instead addSlot or something...
			addSlot("doSomething", letMeDoSomething);
			addSlot("doSomething", letMeDoSomethingElse);
		}
		
		private function letMeDoSomething(s:IValueObject):void 
		{
			//removeSlot("doSomething");
			
			//do some business logic calulations, get some data etc and then:
			sendSignal("updateView");
		}
		
		private function letMeDoSomethingElse(s:IValueObject):void 
		{
			trace("model is doing something else");
		}
		
	}

}