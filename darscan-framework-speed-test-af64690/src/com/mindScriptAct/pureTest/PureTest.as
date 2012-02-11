package com.mindScriptAct.pureTest {
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.utils.getTimer;
import net.bigpoint.utils.benchmark.BenchMark;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
public class PureTest extends Sprite {
	
	public var initTime:int;
	
	public function PureTest()
	{
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(event:Event = null):void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		//
		//BenchMark.monitor(this.stage);
				
		this.initTime = getTimer();
		
		new PureTestFacade().startUp(this);
	}
}
}