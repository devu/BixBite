package com.mindScriptAct.robotTest.view.testSprite {
import com.mindScriptAct.commons.view.TestSprite;
import com.mindScriptAct.robotTest.view.application.MediatorTestEvent;
import org.robotlegs.mvcs.Mediator;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class RobotTestSpriteMediator extends Mediator {
	[Inject]
	public var view:TestSprite;
	
	public function RobotTestSpriteMediator(){
		super();
	}
	
	public override function onRegister():void {
		view.x = Math.random() * 700;
		view.y = Math.random() * 300 + 300;
		
		addContextListener(MediatorTestEvent.COMMUNICATION_TEST, handleOjectSearch);
	}
	
	private function handleOjectSearch(event:MediatorTestEvent):void {
		if (view.uniqueId == event.uniqueId){
			//trace("object found: " + view.uniqueId + " " + view);
		}
	}

}
}