package org.bixbite.examples.stats.model 
{
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.getTimer;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	import org.bixbite.examples.stats.signal.StatsSignal;
	import org.bixbite.examples.stats.signal.TraceSignal;
	
	/**
	 * StatsModel, handles all busines logic and calculations on Enter Frame.
	 */
	public class StatsModel extends Model 
	{
		private var statsSignal:StatsSignal;
		
		private var mem				:Number = 0;
		private var max				:Number = 0;
		private var fps				:Number = 0;
		
		private var timer			:int;
		private var ms				:int;
		private var ms_prev			:int;
		
		private var data			:Array = [];
		
		public function StatsModel() 
		{
			
		}
		
		/**
		 * Attach custom signal and default slots.
		 */
		override public function init():void 
		{
			statsSignal = new StatsSignal();
			attachSignal(statsSignal);
			
			addSlot(StatsSignal.START, onStart);
			addSlot(StatsSignal.PAUSE, onPause);
			addSlot(StatsSignal.TRACE, onTrace);
			
			onStart(statsSignal);
		}
		
		private function onStart(s:ISignal):void 
		{
			system.addListener(Event.ENTER_FRAME, calculate);
		}
		
		private function onPause(s:ISignal):void
		{
			system.removeListener(Event.ENTER_FRAME, calculate);
		}
		
		private function onTrace(s:TraceSignal):void 
		{
			data[s.line] = { name:s.name, value:s.value };
			updateTrace();
		}
		
		/**
		 * On EnterFrame perform calculations, update signal values and broadcast it.
		 * @param	e
		 */
		private function calculate(e:Event):void 
		{
			timer = getTimer();
			
			if( timer - 1000 >= ms_prev){
				ms_prev = timer;
				mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				max = max > mem ? max : mem;
				
				invalidate();
				sendSignal(StatsSignal.DRAW);
				
				statsSignal.infoFPS = "FPS: " + fps + " / " + system.stage.frameRate;
				statsSignal.infoMEM = "MEM: " + mem;
				statsSignal.infoMAX = "MAX: " + max;
				
				fps = 0;
			}
			
			fps++;
			
			statsSignal.infoMS = "MS: " + (timer - ms);
			sendSignal(StatsSignal.UPDATE);
			ms = timer;
		}
		
		private function invalidate():void 
		{
			statsSignal.ms = ms;
			statsSignal.timer = timer;
			statsSignal.max = max;
			statsSignal.mem = mem;
			statsSignal.fps = fps;
		}
		
		private function updateTrace():void
		{
			statsSignal.infoTRACE = "";
			for (var i:int = 0; i < data.length; i++)
				statsSignal.infoTRACE += (data[i] == null) ? "\n" : data[i].name + " " + data[i].value +"\n";
			
			sendSignal(StatsSignal.DISPLAY_TRACE);
		}
		
	}

}