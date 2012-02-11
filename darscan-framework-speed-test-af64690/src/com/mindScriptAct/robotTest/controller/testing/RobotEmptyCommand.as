package com.mindScriptAct.robotTest.controller.testing {
import org.robotlegs.mvcs.Command;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
// don't need to extend mvcs.Command 
// esp if nothing from it is used by the command
// injection is still performed
public class RobotEmptyCommand {
	
	public function execute():void {
		//trace( "RobotEmptyCommand.execute" );
	}

}
}