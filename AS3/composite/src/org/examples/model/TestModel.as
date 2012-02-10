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
			attachSignal("doSomething", letMeDoSomething);
		}
		
		private function letMeDoSomething(s:IValueObject):void 
		{
			//trace(" - > hello I am a model ->");
			//detachSignal("doSomething");
			
			//do some business logic calulations, get some data etc and then:
			sendSignal("updateView");
			
			//notify our TopView and pass ove value object
			sendSignal("showResults", s);
		}
		
	}

}