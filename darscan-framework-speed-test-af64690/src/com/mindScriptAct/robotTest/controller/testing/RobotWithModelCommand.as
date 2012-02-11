package com.mindScriptAct.robotTest.controller.testing {
import com.mindScriptAct.robotTest.model.mock.MockModel;
import org.robotlegs.mvcs.Command;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class RobotWithModelCommand {
	
	[Inject]
	public var mockModel:MockModel;
	
	public function execute():void {
		//trace( "RobotWithModelCommand.execute" );
	}

}
}