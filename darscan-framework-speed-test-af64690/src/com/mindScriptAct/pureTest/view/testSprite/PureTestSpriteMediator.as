package com.mindScriptAct.pureTest.view.testSprite {
import com.mindScriptAct.commons.view.TestSprite;
import com.mindScriptAct.pureTest.notes.Note;
import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class PureTestSpriteMediator extends Mediator implements IMediator {
	public static const PRE_NAME:String = "PureTestObjectMediator_";
	
	/** viewComponent local reference */
	private var testObj:TestSprite;
	
	public function PureTestSpriteMediator(initViewComponent:TestSprite, uniqueId:int){
		super(PRE_NAME + uniqueId);
		this.testObj = initViewComponent;
	}
	
	override public function onRegister():void {
		testObj.x = Math.random() * 700;
		testObj.y = Math.random() * 300 + 300;
	}
	
	override public function onRemove():void {
	}
	
	override public function listNotificationInterests():Array {
		return [ //
			Note.MEDIATOR_COMM_TEST //
			];
	}
	
	override public function handleNotification(notice:INotification):void {
		switch (notice.getName()){
			case Note.MEDIATOR_COMM_TEST: 
				if ((notice.getBody() as int) == testObj.uniqueId){
					//trace("object found: " + testObj.uniqueId + " " + testObj);
				}
				break;
			default: 
				trace(" WARNING : PureTestObjectMediator does not handle notificotion:", notice.getName());
				break;
		}
	}

}
}