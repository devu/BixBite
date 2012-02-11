package com.mindScriptAct.bixbite.controller.testing 
{
	import com.mindScriptAct.bixbite.notes.Note;
	import org.bixbite.framework.core.Controller;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MockController extends Controller 
	{
		
		public function MockController() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(Note.CALL_COMMANDS_WITH_MODEL, execute);
		}
		
		private function execute(s:IValueObject):void 
		{
			sendSignal(Note.CALL_MODEL);
		}
		
	}

}