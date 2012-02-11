package com.mindScriptAct.robotTest.model.mock {
import com.mindScriptAct.robotTest.controller.testing.TestEvent;
import org.robotlegs.mvcs.Actor;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class MockModel extends Actor {
	
	public function MockModel(){
	}
	
	public function invokeMediator():void {
		dispatch(new TestEvent(TestEvent.ACTIVATE_MEDIATOR));
	}

}
}