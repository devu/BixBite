package com.mindScriptAct.pureTest {
import com.gskinner.performance.MethodTest;
import com.gskinner.performance.PerformanceTest;
import com.gskinner.performance.TestSuite;
import com.mindScriptAct.commons.constants.TestNames;
import com.mindScriptAct.pureTest.controller.testing.PureEmptyCommand;
import com.mindScriptAct.pureTest.controller.testing.PureGetParamsCommand;
import com.mindScriptAct.pureTest.controller.testing.PureWithModelCallViewCommand;
import com.mindScriptAct.pureTest.controller.testing.PureWithModelCommand;
import com.mindScriptAct.pureTest.model.mock.MockProxy;
import com.mindScriptAct.pureTest.notes.Note;
import com.mindScriptAct.pureTest.view.application.PureTestMediator;
import flash.events.Event;
import flash.system.Capabilities;
import flash.utils.getTimer;
import org.puremvc.as3.interfaces.IFacade;
import org.puremvc.as3.patterns.facade.Facade;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class PureTestFacade extends Facade implements IFacade {
	private static const STARTUP:String = "startup";
	
	private var performanceTest:PerformanceTest;
	
	public static function getInstance():PureTestFacade {
		if (instance == null)
			instance = new PureTestFacade();
		return instance as PureTestFacade;
	}
	
	public function startUp(mainObj:PureTest):void {
		
		var coreInitTime:int = getTimer() - mainObj.initTime;
		
		// controller
		registerCommand(Note.CALL_COMMANDS_EMPTY, PureEmptyCommand);
		registerCommand(Note.CALL_COMMANDS_GET_PARAMS, PureGetParamsCommand);
		registerCommand(Note.CALL_COMMANDS_WITH_MODEL, PureWithModelCommand);
		registerCommand(Note.CALL_COMMANDS_WITH_MODEL_COMM_VIEWS, PureWithModelCallViewCommand);
		
		// model
		registerProxy(new MockProxy());
		
		// view
		registerMediator(new PureTestMediator(mainObj));
		
		// start
		sendNotification(STARTUP, mainObj);
		removeCommand(STARTUP);
		
		sendNotification(Note.OUTPUT_APPEND_LINE, "PureMVC testing:       [" + (Capabilities.isDebugger ? "DEBUG" : "RELEASE") + " PLAYER. " + Capabilities.version + "]");
		sendNotification(Note.OUTPUT_APPEND_LINE, TestNames.CORE_INIT + ":" + "\t" + coreInitTime);
		
		// init testing
		prepareTests();
	
	}
	
	private function prepareTests():void {
		
		performanceTest = new PerformanceTest();
		performanceTest.delay = 1;
		
		performanceTest.queueSimpleTest(sendNotification, [Note.CALL_COMMANDS_EMPTY], TestNames.COMMAND_EMPTY, 50, 3000);
		performanceTest.queueSimpleTest(sendNotification, [Note.CALL_COMMANDS_GET_PARAMS, "testData"], TestNames.COMMAND_PARAMS, 50, 3000);
		performanceTest.queueSimpleTest(sendNotification, [Note.CALL_COMMANDS_WITH_MODEL], TestNames.COMMAND_MODEL, 50, 3000);
		performanceTest.queueSimpleTest(sendNotification, [Note.CALL_COMMANDS_WITH_MODEL_COMM_VIEWS], TestNames.COMMAND_MODEL_AND_VIEW, 50, 3000);
		//
		performanceTest.queueSimpleTest(sendNotification, [Note.CREATE_TEST_VIEW, 1], TestNames.MEDIATOR_CREATE_1000, 2, 500);
		performanceTest.queueSimpleTest(sendNotification, [Note.REMOVE_TEST_VIEW, 1], TestNames.MEDIATOR_REMOVE_1000, 2, 500);
		performanceTest.queueSimpleTest(sendNotification, [Note.CREATE_TEST_VIEW, 1], TestNames.MEDIATOR_CREATE_2000, 4, 500);
		performanceTest.queueSimpleTest(sendNotification, [Note.REMOVE_TEST_VIEW, 1], TestNames.MEDIATOR_REMOVE_2000, 4, 500);
		performanceTest.queueSimpleTest(sendNotification, [Note.CREATE_TEST_VIEW, 1], TestNames.MEDIATOR_CREATE_5000, 10, 500);
		performanceTest.queueSimpleTest(sendNotification, [Note.REMOVE_TEST_VIEW, 1], TestNames.MEDIATOR_REMOVE_5000, 10, 500);
		
		performanceTest.queueSimpleTest(sendNotification, [Note.MEDIATOR_COMM_TEST], TestNames.MEDIATOR_COMMUNICATE_1, 100, 10000);
		
		performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendNotification, [Note.MEDIATOR_COMM_TEST, 1], TestNames.MEDIATOR_COMMUNICATE_100, 50, 1000)], "Communication test 100", null, spawn100Mediators));
		performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendNotification, [Note.MEDIATOR_COMM_TEST, 1], TestNames.MEDIATOR_COMMUNICATE_200, 50, 1000)], "Communication test 200", null, spawn100Mediators));
		performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendNotification, [Note.MEDIATOR_COMM_TEST, 1], TestNames.MEDIATOR_COMMUNICATE_500, 40, 1000)], "Communication test 500", null, spawn300Mediators));
		performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendNotification, [Note.MEDIATOR_COMM_TEST, 1], TestNames.MEDIATOR_COMMUNICATE_1000, 30, 1000)], "Communication test 1000", null, spawn500Mediators));
		
		performanceTest.addEventListener(Event.COMPLETE, handleTestComplete);
		performanceTest.addEventListener(Event.CLOSE, handleTestClose);
	}
	
	private function spawn100Mediators():void {
		for (var i:int = 0; i < 100; i++){
			sendNotification(Note.CREATE_TEST_VIEW, 1);
		}
	}
	
	private function spawn300Mediators():void {
		for (var i:int = 0; i < 300; i++){
			sendNotification(Note.CREATE_TEST_VIEW, 1);
		}
	}
	
	private function spawn500Mediators():void {
		for (var i:int = 0; i < 500; i++){
			sendNotification(Note.CREATE_TEST_VIEW, 1);
		}
	}
	
	private function handleTestClose(event:Event):void {
		//trace( "RobotTestContext.handleTestClose > event : " + event );
		for (var i:int = 0; i < 1000; i++){
			sendNotification(Note.REMOVE_TEST_VIEW, 1);
		}
		sendNotification(Note.OUTPUT_APPEND_LINE, "ALL TESTS DONE");
	}
	
	private function handleTestComplete(event:Event):void {
		//trace("RobotTestContext.handleTestComplete > event : " + event);
		if (performanceTest.currentTest){
			sendNotification(Note.OUTPUT_APPEND_LINE, performanceTest.currentTest.name + ":" + "\t" + (performanceTest.currentTest.time / performanceTest.currentTest.loops) + "\t" + performanceTest.currentTest.toString());
		}
	}

}
}