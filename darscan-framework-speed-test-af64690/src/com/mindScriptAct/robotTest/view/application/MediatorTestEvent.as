package com.mindScriptAct.robotTest.view.application {
import flash.events.Event;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class MediatorTestEvent extends Event {
	
	static public const CREATE_TEST_VIEW:String = "createTestView";
	static public const REMOVE_TEST_VIEW:String = "removeTestView";
	
	static public const COMMUNICATION_TEST:String = "mediatorCommTest";
	
	public var uniqueId:int;
	
	public function MediatorTestEvent(type:String, uniqueId:int){
		super(type);
		this.uniqueId = uniqueId;
	}
	
	public override function clone():Event {
		return new MediatorTestEvent(type, uniqueId);
	}

}
}