package com.mindScriptAct.bixbite.view 
{
	import com.mindScriptAct.bixbite.controller.signals.UniqueVO;
	import com.mindScriptAct.bixbite.notes.Note;
	import com.mindScriptAct.commons.view.TestSprite;
	import org.bixbite.framework.core.View;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestSpriteView extends View 
	{
		private var testObj:TestSprite;
		
		public function TestSpriteView(testObj:TestSprite) 
		{
			content = testObj;
			this.testObj = testObj;
			this.testObj.x = Math.random() * 700;
			this.testObj.y = Math.random() * 300 + 300;
		}
		
		override public function init():void 
		{
			addSlot(Note.MEDIATOR_COMM_TEST, commTest);
		}
		
		private function commTest(s:UniqueVO):void 
		{
			if (s.id == testObj.uniqueId){
				//trace("object found: " + testObj.uniqueId + " " + testObj);
			}
		}
		
	}

}