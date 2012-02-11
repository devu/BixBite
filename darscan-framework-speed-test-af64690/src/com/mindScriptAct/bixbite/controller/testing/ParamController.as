package com.mindScriptAct.bixbite.controller.testing 
{
	import com.mindScriptAct.bixbite.controller.signals.ParamsVO;
	import com.mindScriptAct.bixbite.notes.Note;
	import org.bixbite.framework.core.Controller;
	import org.bixbite.framework.interfaces.IValueObject;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ParamController extends Controller 
	{
		
		public function ParamController() 
		{
			
		}
		
		override public function init():void 
		{
			addSlot(Note.CALL_COMMANDS_GET_PARAMS, execute);
		}
		
		private function execute(s:ParamsVO):void 
		{
			var data:String = s.data;
		}
		
	}

}