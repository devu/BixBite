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

package org.bixbite.framework.modules.stats.behaviour 
{
	import flash.system.System;
	import flash.utils.getTimer;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.modules.stats.data.StatsData;
	import org.bixbite.framework.signals.StatsSignal;
	
	/**
	 * @version  compatibility - 0.5.2
	 * @since 0.5.0
	 */
	public class Calculate extends Behaviour 
	{
		private var data		:StatsData;
		private var fps			:int;
		private var timer		:int;
		private var ms_prev		:int;
		
		public function Calculate() 
		{
			
		}
		
		override public function init():void 
		{
			addResponder(StatsSignal.DATA_REQUEST, onData, true);
		}
		
		private function onData(s:ISignal, data:StatsData):void 
		{
			this.data = data;
		}
		
		override public function execute(s:ISignal):void 
		{
			timer = getTimer();
			data.timer = timer;
			
			var max			:Number = data.max;
			var mem			:Number = data.mem;
			var frameRate	:int 	= data.frameRate;
			var ms			:int 	= data.ms;
			
			if( timer - 1000 >= ms_prev){
				ms_prev = timer;
				
				data.mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				data.max = max > mem ? max : mem;
				data.fps = fps;
				
				sendSignal(StatsSignal.DRAW, [data]);
				
				data.infoFPS = "FPS: " + fps + " / " + frameRate;
				data.infoMEM = "MEM: " + mem;
				data.infoMAX = "MAX: " + data.max;
				data.infoMS  = "MS: " + (timer - ms);
				
				sendSignal(StatsSignal.UPDATE, [data]);
				
				fps = 0;
			}
			
			fps++;
			
			data.infoMS  = "MS: " + (timer - ms);
			sendSignal(StatsSignal.UPDATE_REALTIME, [data]);
				
			data.ms = timer;
		}
		
		
	}

}