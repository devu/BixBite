package com.mindScriptAct.robotTest {
import com.gskinner.performance.MethodTest;
import com.gskinner.performance.PerformanceTest;
import com.gskinner.performance.TestSuite;
import com.gskinner.performance.TextLog;
import com.mindScriptAct.commons.constants.TestNames;
import com.mindScriptAct.commons.view.TestSprite;
import com.mindScriptAct.robotTest.controller.testing.RobotEmptyCommand;
import com.mindScriptAct.robotTest.controller.testing.RobotGetParamsCommand;
import com.mindScriptAct.robotTest.controller.testing.RobotWithModelCommViewsCommand;
import com.mindScriptAct.robotTest.controller.testing.RobotWithModelCommand;
import com.mindScriptAct.robotTest.controller.testing.TestEvent;
import com.mindScriptAct.robotTest.model.mock.MockModel;
import com.mindScriptAct.robotTest.view.application.MediatorTestEvent;
import com.mindScriptAct.robotTest.view.application.OutputEvent;
import com.mindScriptAct.robotTest.view.application.RobotTestMediator;
import com.mindScriptAct.robotTest.view.testSprite.RobotTestSpriteMediator;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.TextEvent;
import flash.net.URLRequestMethod;
import flash.sampler.NewObjectSample;
import flash.system.Capabilities;
import flash.system.System;
import flash.utils.getTimer;

import org.robotlegs.mvcs.Context;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class RobotTestContext extends Context {
	private var performanceTest:PerformanceTest;
	private var coreInitTime:int;
	
	public function RobotTestContext(contextView:DisplayObjectContainer){
		super(contextView);
	}
	
	override public function startup():void {
		//trace("CoreTestContext.startup");
		
		coreInitTime = getTimer() - (contextView as RobotTest).initTime;
		
		// controller
		commandMap.mapEvent(TestEvent.CALL_COMMANDS_EMPTY, RobotEmptyCommand);
		commandMap.mapEvent(TestEvent.CALL_COMMANDS_GET_PARAMS, RobotGetParamsCommand);
		commandMap.mapEvent(TestEvent.CALL_COMMANDS_WITH_MODEL, RobotWithModelCommand);
		commandMap.mapEvent(TestEvent.CALL_COMMANDS_WITH_MODEL_COMM_VIEWS, RobotWithModelCommViewsCommand);
		
		// model
		injector.mapSingleton(MockModel);
		
		// view
		mediatorMap.mapView(RobotTest, RobotTestMediator);
		mediatorMap.mapView(TestSprite, RobotTestSpriteMediator);
		
		// start
		super.startup();
		
		dispatchEvent(new OutputEvent(OutputEvent.APPEND_LINE, "RobotLegs testing:       [" + (Capabilities.isDebugger ? "DEBUG" : "RELEASE") + " PLAYER. " + Capabilities.version + "]"));
		dispatchEvent(new OutputEvent(OutputEvent.APPEND_LINE, TestNames.CORE_INIT + ":" + "\t" + coreInitTime));
		
		// init testing
		prepareTests();
	}
	
	private function prepareTests():void {
		
		performanceTest = new PerformanceTest();
		// there needs to be some cool down time between tests
		// the default is 50 with advice to turn it up for "a series of high intensity tests", not down
		performanceTest.delay = 60;
		
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new TestEvent(TestEvent.CALL_COMMANDS_EMPTY)], TestNames.COMMAND_EMPTY, 50, 3000);
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new TestEvent(TestEvent.CALL_COMMANDS_GET_PARAMS, "testData")], TestNames.COMMAND_PARAMS, 50, 3000);
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new TestEvent(TestEvent.CALL_COMMANDS_WITH_MODEL)], TestNames.COMMAND_MODEL, 50, 3000);
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new TestEvent(TestEvent.CALL_COMMANDS_WITH_MODEL_COMM_VIEWS)], TestNames.COMMAND_MODEL_AND_VIEW, 50, 3000);
		
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.CREATE_TEST_VIEW, 1)], TestNames.MEDIATOR_CREATE_1000, 2, 500);
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.REMOVE_TEST_VIEW, 1)], TestNames.MEDIATOR_REMOVE_1000, 2, 500);
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.CREATE_TEST_VIEW, 1)], TestNames.MEDIATOR_CREATE_2000, 4, 500);
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.REMOVE_TEST_VIEW, 1)], TestNames.MEDIATOR_REMOVE_2000, 4, 500);
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.CREATE_TEST_VIEW, 1)], TestNames.MEDIATOR_CREATE_5000, 10, 500);
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.REMOVE_TEST_VIEW, 1)], TestNames.MEDIATOR_REMOVE_5000, 10, 500);
		
		performanceTest.queueSimpleTest(eventDispatcher.dispatchEvent, [new TestEvent(TestEvent.ACTIVATE_MEDIATOR)], TestNames.MEDIATOR_COMMUNICATE_1, 100, 10000);
		
		performanceTest.queueTestSuite(new TestSuite([new MethodTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.COMMUNICATION_TEST, 1)], TestNames.MEDIATOR_COMMUNICATE_100, 50, 1000)], "Communication test 100", null, spawn100Mediators));
		performanceTest.queueTestSuite(new TestSuite([new MethodTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.COMMUNICATION_TEST, 1)], TestNames.MEDIATOR_COMMUNICATE_200, 50, 1000)], "Communication test 200", null, spawn100Mediators));
		performanceTest.queueTestSuite(new TestSuite([new MethodTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.COMMUNICATION_TEST, 1)], TestNames.MEDIATOR_COMMUNICATE_500, 40, 1000)], "Communication test 500", null, spawn300Mediators));
		performanceTest.queueTestSuite(new TestSuite([new MethodTest(eventDispatcher.dispatchEvent, [new MediatorTestEvent(MediatorTestEvent.COMMUNICATION_TEST, 1)], TestNames.MEDIATOR_COMMUNICATE_1000, 30, 1000)], "Communication test 1000", null, spawn500Mediators));
		
		performanceTest.addEventListener(Event.COMPLETE, handleTestComplete);
		performanceTest.addEventListener(Event.CLOSE, handleTestClose);
	}
	
	private function spawn100Mediators():void {
		for (var i:int = 0; i < 100; i++){
			eventDispatcher.dispatchEvent(new MediatorTestEvent(MediatorTestEvent.CREATE_TEST_VIEW, 1));
		}
	}
	
	private function spawn300Mediators():void {
		for (var i:int = 0; i < 300; i++){
			eventDispatcher.dispatchEvent(new MediatorTestEvent(MediatorTestEvent.CREATE_TEST_VIEW, 1));
		}
	}
	
	private function spawn500Mediators():void {
		for (var i:int = 0; i < 500; i++){
			eventDispatcher.dispatchEvent(new MediatorTestEvent(MediatorTestEvent.CREATE_TEST_VIEW, 1));
		}
	}
	
	private function handleTestClose(event:Event):void {
		var taken:Number = (getTimer() - coreInitTime) / 1000;
		//trace( "RobotTestContext.handleTestClose > event : " + event );
		for (var i:int = 0; i < 1000; i++){
			eventDispatcher.dispatchEvent(new MediatorTestEvent(MediatorTestEvent.REMOVE_TEST_VIEW, 1));
		}
		dispatchEvent(new OutputEvent(OutputEvent.APPEND_LINE, "ALL TESTS DONE"));
		dispatchEvent(new OutputEvent(OutputEvent.APPEND_LINE, "IN: " + taken.toFixed(2)));
	}
	
	private function handleTestComplete(event:Event):void {
		//trace("RobotTestContext.handleTestComplete > event : " + event);
		if (performanceTest.currentTest){
			dispatchEvent(new OutputEvent(OutputEvent.APPEND_LINE, performanceTest.currentTest.name + ":" + "\t" + (performanceTest.currentTest.time / performanceTest.currentTest.loops) + "\t" + performanceTest.currentTest.toString()));
		}
	}
}

}