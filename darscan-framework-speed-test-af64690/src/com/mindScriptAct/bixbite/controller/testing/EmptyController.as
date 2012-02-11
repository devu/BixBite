package com.mindScriptAct.bixbite.controller.testing 
{
	import com.mindScriptAct.bixbite.notes.Note;
	import org.bixbite.framework.core.Controller;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class EmptyController extends Controller 
	{
		
		public function EmptyController() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(Note.CALL_COMMANDS_EMPTY, execute);
		}
		
		private function execute(s:IValueObject):void 
		{
			//empty
		}
		
	}

}