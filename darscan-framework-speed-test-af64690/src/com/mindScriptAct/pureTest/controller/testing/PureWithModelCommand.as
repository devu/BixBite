package com.mindScriptAct.pureTest.controller.testing {
import com.mindScriptAct.pureTest.model.mock.MockProxy;
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class PureWithModelCommand extends SimpleCommand {
	
	override public function execute(notice:INotification):void {
		//trace( "PureWithModelCommand.execute > notice : " + notice );
		var mockProxy:MockProxy = facade.retrieveProxy(MockProxy.NAME) as MockProxy;
	}

}
}