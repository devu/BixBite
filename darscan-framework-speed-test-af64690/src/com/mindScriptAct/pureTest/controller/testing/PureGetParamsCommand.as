package com.mindScriptAct.pureTest.controller.testing {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class PureGetParamsCommand extends SimpleCommand {
	
	override public function execute(notice:INotification):void {
		//trace( "PureGetParamsCommand.execute > notice : " + notice );
		var data:String = notice.getBody() as String;
	}

}
}