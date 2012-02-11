package com.mindScriptAct.robotTest.controller.testing {
import org.robotlegs.mvcs.Command;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class RobotGetParamsCommand {
	
	[Inject]
	public var event:TestEvent;
	
	public function execute():void {
		//trace( "RobotGetParamsCommand.execute" );
		var data:String = event.data;
	}

}

}