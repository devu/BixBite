package com.mindScriptAct.bixbite.controller.testing 
{
	import com.mindScriptAct.bixbite.notes.Note;
	import org.bixbite.framework.core.Controller;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class InvokeController extends Controller 
	{
		
		public function InvokeController() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(Note.CALL_COMMANDS_WITH_MODEL_COMM_VIEWS, execute);
		}
		
		private function execute(s:IValueObject):void 
		{
			sendSignal(Note.CALL_MODEL_COMM_VIEWS);
		}
		
	}

}