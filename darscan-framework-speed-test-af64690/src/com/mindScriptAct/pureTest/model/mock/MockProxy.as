package com.mindScriptAct.pureTest.model.mock {
import com.mindScriptAct.pureTest.notes.Note;
import org.puremvc.as3.interfaces.IProxy;
import org.puremvc.as3.patterns.proxy.Proxy;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class MockProxy extends Proxy implements IProxy {
	public static const NAME:String = "MockProxy";
	
	public function MockProxy() {
		super(NAME);
	}
	
	public function invokeMediator():void {
		sendNotification(Note.ACTIVATE_MEDIATOR);
	}
	
}
}