package com.mindScriptAct.bixbite 
{
	import com.gskinner.performance.MethodTest;
	import com.gskinner.performance.PerformanceTest;
	import com.gskinner.performance.TestSuite;
	import com.mindScriptAct.bixbite.controller.signals.MessageVO;
	import com.mindScriptAct.bixbite.controller.signals.ParamsVO;
	import com.mindScriptAct.bixbite.controller.signals.UniqueVO;
	import com.mindScriptAct.bixbite.controller.testing.EmptyController;
	import com.mindScriptAct.bixbite.controller.testing.InvokeController;
	import com.mindScriptAct.bixbite.controller.testing.MockController;
	import com.mindScriptAct.bixbite.controller.testing.ParamController;
	import com.mindScriptAct.bixbite.model.MockModel;
	import com.mindScriptAct.bixbite.notes.Note;
	import com.mindScriptAct.bixbite.view.TestSpriteView;
	import com.mindScriptAct.commons.constants.TestNames;
	import com.mindScriptAct.commons.view.TestSprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.bixbite.framework.core.Application;
	import org.bixbite.framework.interfaces.IValueObject;
	import org.bixbite.framework.interfaces.IView;
	
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class BixbiteTest extends Application 
	{
		private var performanceTest	:PerformanceTest;
		private var outputTf		:TextField;
		private var viewStack		:Vector.<IView> = new Vector.<IView>();
		
		public function BixbiteTest() 
		{
			
		}
		
		override public function init():void 
		{
			
			//no time, you already working with it :)
			var coreInitTime:int = 0;
			
			// controller
			new EmptyController();
			new ParamController();
			new MockController();
			new InvokeController();
			
			// model
			new MockModel();
			
			// view - Application act as TopView
			addOutput();
			
			addSlot(Note.OUTPUT_APPEND_LINE, appendLine);
			addSlot(Note.CREATE_TEST_VIEW, createTestView);
			addSlot(Note.REMOVE_TEST_VIEW, removeTestView);
			addSlot(Note.ACTIVATE_MEDIATOR, activateTestView);
			
			sendSignal(Note.OUTPUT_APPEND_LINE, new MessageVO("Bixbite testing:       [" + (Capabilities.isDebugger ? "DEBUG" : "RELEASE") + " PLAYER. " + Capabilities.version + "]"));
			sendSignal(Note.OUTPUT_APPEND_LINE, new MessageVO(TestNames.CORE_INIT + ":" + "\t" + coreInitTime));
			
			// init testing
			prepareTests();
		}
		
		private function appendLine(s:MessageVO):void 
		{
			outputTf.appendText(s.msg + "\n");
		}
		
		private function createTestView(s:UniqueVO):void 
		{
			var uniqueId:int = viewStack.length;
			viewStack.push(addView(new TestSpriteView(new TestSprite(uniqueId))));
		}
		
		private function removeTestView(s:IValueObject):void 
		{
			while (viewStack.length > 0) removeView(viewStack.pop());
		}
		
		private function activateTestView(s:IValueObject):void
		{
			// do stuff;
		}
		
		private function addOutput():void 
		{
			outputTf = new TextField();
			addChild(outputTf);
			
			outputTf.text = '';
			outputTf.autoSize = TextFieldAutoSize.LEFT;
			outputTf.multiline = true;
			outputTf.selectable = true;
			outputTf.border = true;
		}
		
		private function prepareTests():void 
		{
			performanceTest = new PerformanceTest();
			performanceTest.delay = 1;
			
			performanceTest.queueSimpleTest(sendSignal, [Note.CALL_COMMANDS_EMPTY], TestNames.COMMAND_EMPTY, 50, 3000);
			performanceTest.queueSimpleTest(sendSignal, [Note.CALL_COMMANDS_GET_PARAMS, new ParamsVO("testData")], TestNames.COMMAND_PARAMS, 50, 3000);
			performanceTest.queueSimpleTest(sendSignal, [Note.CALL_COMMANDS_WITH_MODEL], TestNames.COMMAND_MODEL, 50, 3000);
			performanceTest.queueSimpleTest(sendSignal, [Note.CALL_COMMANDS_WITH_MODEL_COMM_VIEWS], TestNames.COMMAND_MODEL_AND_VIEW, 50, 3000);
			
			performanceTest.queueSimpleTest(sendSignal, [Note.CREATE_TEST_VIEW, new UniqueVO(1)], TestNames.MEDIATOR_CREATE_1000, 2, 500);
			performanceTest.queueSimpleTest(sendSignal, [Note.REMOVE_TEST_VIEW, new UniqueVO(1)], TestNames.MEDIATOR_REMOVE_1000, 2, 500);
			performanceTest.queueSimpleTest(sendSignal, [Note.CREATE_TEST_VIEW, new UniqueVO(1)], TestNames.MEDIATOR_CREATE_2000, 4, 500);
			performanceTest.queueSimpleTest(sendSignal, [Note.REMOVE_TEST_VIEW, new UniqueVO(1)], TestNames.MEDIATOR_REMOVE_2000, 4, 500);
			performanceTest.queueSimpleTest(sendSignal, [Note.CREATE_TEST_VIEW, new UniqueVO(1)], TestNames.MEDIATOR_CREATE_5000, 10, 500);
			performanceTest.queueSimpleTest(sendSignal, [Note.REMOVE_TEST_VIEW, new UniqueVO(1)], TestNames.MEDIATOR_REMOVE_5000, 10, 500);
			
			// the reason for number of loops set to 1 is simple
			// Bixbite will broadcast signal to all active Actors of the MVC automatically, you don't have to iterate through all of them
			// this is multicast Signal system implementation, however if you need to selectively call the members of the triad use sendSignalTo instead
			// Bixbite is capable of sending one signal to 3.7 millions of views per second, I don't thing any AS3 framework is close to this number.
			// There is no proper destroyView mechanism implemented yet, it might be the case that those numbers will go even lower, but I don't mind for now ;)
			//performanceTest.queueSimpleTest(sendSignal, [Note.MEDIATOR_COMM_TEST], TestNames.MEDIATOR_COMMUNICATE_1, 100, 1);
			
			performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendSignal, [Note.MEDIATOR_COMM_TEST, new UniqueVO(1)], TestNames.MEDIATOR_COMMUNICATE_1, 50, 1)], "Communication test 1", null, spawn1Mediator));
			performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendSignal, [Note.MEDIATOR_COMM_TEST, new UniqueVO(1)], TestNames.MEDIATOR_COMMUNICATE_100, 50, 1)], "Communication test 100", null, spawn100Mediators));
			performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendSignal, [Note.MEDIATOR_COMM_TEST, new UniqueVO(1)], TestNames.MEDIATOR_COMMUNICATE_200, 50, 1)], "Communication test 200", null, spawn100Mediators));
			performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendSignal, [Note.MEDIATOR_COMM_TEST, new UniqueVO(1)], TestNames.MEDIATOR_COMMUNICATE_500, 40, 1)], "Communication test 500", null, spawn300Mediators));
			performanceTest.queueTestSuite(new TestSuite([new MethodTest(sendSignal, [Note.MEDIATOR_COMM_TEST, new UniqueVO(1)], TestNames.MEDIATOR_COMMUNICATE_1000, 30, 1)], "Communication test 1000", null, spawn500Mediators));
			
			performanceTest.addEventListener(Event.COMPLETE, handleTestComplete);
			performanceTest.addEventListener(Event.CLOSE, handleTestClose);
		}
		
		private function spawn1Mediator():void {
			sendSignal(Note.CREATE_TEST_VIEW, new UniqueVO(1));
		}
		
		private function spawn100Mediators():void {
			for (var i:int = 0; i < 100; i++){
				sendSignal(Note.CREATE_TEST_VIEW, new UniqueVO(1));
			}
		}
		
		private function spawn300Mediators():void {
			for (var i:int = 0; i < 300; i++){
				sendSignal(Note.CREATE_TEST_VIEW, new UniqueVO(1));
			}
		}
		
		private function spawn500Mediators():void {
			for (var i:int = 0; i < 500; i++){
				sendSignal(Note.CREATE_TEST_VIEW, new UniqueVO(1));
			}
		}
		
		private function handleTestClose(event:Event):void {
			
			sendSignal(Note.REMOVE_TEST_VIEW, new UniqueVO(1));
			sendSignal(Note.OUTPUT_APPEND_LINE, new MessageVO("ALL TESTS DONE"));
		}
	
		private function handleTestComplete(event:Event):void {
			
			if (performanceTest.currentTest){
				sendSignal(Note.OUTPUT_APPEND_LINE, new MessageVO(performanceTest.currentTest.name + ":" + "\t" + (performanceTest.currentTest.time / performanceTest.currentTest.loops) + "\t" + performanceTest.currentTest.toString()));
			}
		}
		
	}

}