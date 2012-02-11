package com.mindScriptAct.robotTest.controller.testing {
import flash.events.Event;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class TestEvent extends Event {
	
	static public const CALL_COMMANDS_EMPTY:String = "callCommandsEmpty";
	static public const CALL_COMMANDS_WITH_MODEL:String = "callCommandsWithModel";
	static public const CALL_COMMANDS_GET_PARAMS:String = "callCommandsGetParams";
	static public const CALL_COMMANDS_WITH_MODEL_COMM_VIEWS:String = "callCommandsWithModelCommViews";
	
	static public const ACTIVATE_MEDIATOR:String = "activateMediator";
	
	public var data:String;
	
	public function TestEvent(type:String, data:String = ""){
		super(type);
		this.data = data;
	}
	
	public override function clone():Event {
		return new TestEvent(type, data);
	}

}
}