/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.behaviour 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.getTimer;
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.data.StatsData;
	import org.bixbite.Stats;
	
	/**
	 * @langversion	3.0
	 */
	public class StatsCalculate extends Behaviour 
	{
		private var data		:StatsData;
		private var stage		:Stage;
		
		private var fps			:int;
		private var timer		:int;
		private var ms_prev		:int;
		private var frameRate	:int;
		
		private var updateSRS			:Function;
		private var updateRealtimeSRS	:Function;
		
		override public function init():void
		{
			addResponder(Stats.DATA_REQUEST, onData, true);
			
			updateSRS = getSlots(Stats.UPDATE).getSlotByIndex(0).send;
			updateRealtimeSRS = getSlots(Stats.UPDATE_REALTIME).getSlotByIndex(0).send;
		}
		
		private function onData(data:StatsData):void 
		{
			this.data = data;
			removeResponder(Stats.DATA_REQUEST);
		}
		
		override public function execute(s:Signal):void 
		{
			stage		= s.params.root;
			frameRate	= stage.frameRate;
			stage.addEventListener(Event.ENTER_FRAME, calculate);
		}
		
		private function calculate(e:Event):void 
		{
			timer = getTimer();
			
			var max		:Number = data.max;
			var mem		:Number = data.mem;
			var ms		:int 	= data.ms;
			
			frameRate			= stage.frameRate;
			data.frameRate		= frameRate;
			signal.params 		= data;
			
			if( timer - 1000 >= ms_prev){
				ms_prev = timer;
				
				data.mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				data.max = max > mem ? max : mem;
				data.fps = fps;
				
				data.infoFPS = "FPS: " + fps + " / " + frameRate;
				data.infoMEM = "MEM: " + mem;
				data.infoMAX = "MAX: " + data.max;
				
				updateSRS(signal);
				
				fps = 0;
			}
			
			fps++;
			
			data.infoMS  = "MS: " + (timer - ms);
			updateRealtimeSRS(signal);
			
			data.ms = timer;
		}
		
		override public function dispose():void 
		{
			removeResponder(Stats.DATA_REQUEST);
			
			data = null;
			fps	= timer	= ms_prev = NaN;
			
			updateSRS = null;
			updateRealtimeSRS = null;
			
			super.dispose();
		}
		
	}

}