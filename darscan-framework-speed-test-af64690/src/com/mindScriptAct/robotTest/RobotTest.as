package com.mindScriptAct.robotTest {
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.utils.getTimer;
import flash.utils.setTimeout;

import net.bigpoint.utils.benchmark.BenchMark;

/**
 * ...
 * @author Deril (raima156@yahoo.com)
 */
[SWF(backgroundColor="#FFFFFF", frameRate="50", width="800", height="600")]
public class RobotTest extends Sprite {
	
	public var initTime:int;
	
	private var context:RobotTestContext;
	
	public function RobotTest():void {
		if (stage)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(event:Event = null):void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		// vm warm up:
		setTimeout(start, 2000);
	}
	
	private function start():void
	{
		//
		//this.addChild(new Stats());
		//BenchMark.monitor(this.stage);
		
		this.initTime = getTimer();
		
		context = new RobotTestContext(this);
	}

}

}