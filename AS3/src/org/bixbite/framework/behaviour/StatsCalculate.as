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

package org.bixbite.framework.behaviour 
{
	import flash.system.System;
	import flash.utils.getTimer;
	
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.StatsData;
	import org.bixbite.framework.Stats;
	
	/**
	 * @langversion	3.0
	 */
	public class StatsCalculate extends Behaviour 
	{
		private var data		:StatsData;
		
		private var fps			:int;
		private var timer		:int;
		private var ms_prev		:int;
		
		private var updateSRS			:Function;
		private var updateRealtimeSRS	:Function;
		private var drawSRS				:Function;
		
		override public function init():void
		{
			addResponder(Stats.DATA_REQUEST, onData, true);
			
			updateSRS = getSlots(Stats.UPDATE).getSlotByIndex(0).send;
			updateRealtimeSRS = getSlots(Stats.UPDATE_REALTIME).getSlotByIndex(0).send;
			drawSRS = getSlots(Stats.DRAW).getSlotByIndex(0).send;
		}
		
		private function onData(data:StatsData):void 
		{
			this.data = data;
			removeResponder(Stats.DATA_REQUEST);
		}
		
		override public function execute(s:Signal):void 
		{
			data.timer = timer = getTimer();
			
			var max			:Number = data.max;
			var mem			:Number = data.mem;
			var frameRate	:int 	= data.frameRate;
			var ms			:int 	= data.ms;
			
			signal.params = data;
			
			if( timer - 1000 >= ms_prev){
				ms_prev = timer;
				
				data.mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				data.max = max > mem ? max : mem;
				data.fps = fps;
				
				drawSRS(signal);
				
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
			drawSRS = null;
			
			super.dispose();
		}
		
	}

}