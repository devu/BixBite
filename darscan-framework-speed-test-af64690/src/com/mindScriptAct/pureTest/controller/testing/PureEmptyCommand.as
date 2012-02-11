package com.mindScriptAct.pureTest.controller.testing {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class PureEmptyCommand extends SimpleCommand {
	
	override public function execute(notice:INotification):void {
		//trace( "PureEmptyCommand.execute > notice : " + notice );
	}
	
}
}