package com.mindScriptAct.pureTest.view.application {
import com.mindScriptAct.commons.view.TestSprite;
import com.mindScriptAct.pureTest.notes.Note;
import com.mindScriptAct.pureTest.PureTest;
import com.mindScriptAct.pureTest.view.testSprite.PureTestSpriteMediator;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.Dictionary;
import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class PureTestMediator extends Mediator implements IMediator {
	
	public static const NAME:String = "CoreTestMediator";
	
	private var pureTest:PureTest;
	
	private var outputTf:TextField;
	
	private var childHolder:Sprite = new Sprite();
	private var childStack:Vector.<TestSprite> = new Vector.<TestSprite>();
	
	public function PureTestMediator(initViewComponent:PureTest){
		super(NAME);
		this.pureTest = initViewComponent;
	}
	
	override public function onRegister():void {
		//trace( "PureCoreTestMediator.onRegister" );
		
		pureTest.addChild(childHolder)
		
		addOutput();
	}
	
	override public function onRemove():void {
	}
	
	override public function listNotificationInterests():Array {
		return [ //
			Note.OUTPUT_APPEND_LINE, //
			Note.CREATE_TEST_VIEW, //
			Note.REMOVE_TEST_VIEW, //
			Note.ACTIVATE_MEDIATOR //
			];
	}
	
	override public function handleNotification(notice:INotification):void {
		switch (notice.getName()){
			
			case Note.OUTPUT_APPEND_LINE: 
				outputTf.appendText((notice.getBody() as String) + "\n");
				break;
			
			case Note.CREATE_TEST_VIEW: 
				var uniqueId:int = childStack.length;
				var newObject:TestSprite = new TestSprite(uniqueId);
				facade.registerMediator(new PureTestSpriteMediator(newObject, uniqueId));
				childHolder.addChild(newObject);
				childStack.push(newObject);
				break;
			
			case Note.REMOVE_TEST_VIEW: 
				var oldObject:TestSprite = childStack.pop();
				facade.removeMediator(PureTestSpriteMediator.PRE_NAME + oldObject.uniqueId);
				childHolder.removeChild(oldObject);
				break;
			
			case Note.ACTIVATE_MEDIATOR: 
				// do stuff;
				break;
			
			default: 
				trace(" WARNING : CoreTestMediator does not handle notificotion:", notice.getName());
				break;
		}
	}
	
	private function addOutput():void {
		outputTf = new TextField();
		pureTest.addChild(outputTf);
		
		outputTf.text = '';
		outputTf.autoSize = TextFieldAutoSize.LEFT;
		outputTf.multiline = true;
		outputTf.selectable = true;
		outputTf.border = true;
	}

}
}