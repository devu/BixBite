/**The MIT License

@copy (c) 2012 Devu Design Limited, Daniel Wasilewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package org.bixbite.framework.modules.stats.model 
{
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.getTimer;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.core.Model;
	import org.bixbite.framework.modules.stats.signal.StatsSignal;
	import org.bixbite.framework.modules.stats.signal.TraceSignal;
	
	/**
	 * @version  compatibility - 0.4.2
	 * @since 0.4.1
	 * 
	 * StatsModel, handles all busines logic and calculations on Enter Frame.
	 */
	public class StatsModel extends Model 
	{
		private var statsSignal		:StatsSignal;
		
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
		
		private function onTrace(s:TraceSignal):void 
		{
			data[s.line] = { name:s.name, value:s.value };
			updateTrace();
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