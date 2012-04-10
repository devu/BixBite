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

package org.bixbite.framework.modules.stats.data 
{
	import org.bixbite.core.Data;
	import org.bixbite.framework.signals.StatsSignal;
	
	/**
	 * @version  compatibility - 0.5.0
	 * @since 0.4.1
	 * 
	 */
	public class StatsData extends Data 
	{
		public var mem				:Number = 0;
		public var max				:Number = 0;
		public var fps				:Number = 0;
		
		public var timer			:int;
		public var ms				:int;
		public var ms_prev			:int;
		
		public var frameRate		:Number;
		
		public var infoFPS			:String;
		public var infoMEM			:String;
		public var infoMAX			:String;
		public var infoMS			:String;
		
		public function StatsData()
		{
			frameRate = system.frameRate;
		}
		
		override public function init():void
		{
			addSlot(StatsSignal.DATA_REQUEST, onDataRequest);
		}
		
		private function onDataRequest():StatsData
		{
			return this
		}
		
	}

}