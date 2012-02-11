package com.mindScriptAct.bixbite.model 
{
	import com.mindScriptAct.bixbite.notes.Note;
	import org.bixbite.framework.core.Model;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MockModel extends Model 
	{
		
		public function MockModel() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(Note.CALL_MODEL, onCall);
			addSlot(Note.CALL_MODEL_COMM_VIEWS, onInvoke);
		}
		
		private function onCall(s:IValueObject):void 
		{
			//just do nothing
		}
		
		private function onInvoke(s:IValueObject):void 
		{
			sendSignal(Note.ACTIVATE_MEDIATOR);
		}
		
	}

}