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

package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.StatsCalculate;
	import org.bixbite.framework.data.StatsData;
	import org.bixbite.framework.transponder.StatsTransponder;
	import org.bixbite.framework.view.StatsMonitorView;
	
	/**
	 * @langversion	3.0
	 * 
	 * This is fork of stats by mrdoob implemented within BixBite framework.
	 * 
	 */
	public class Stats extends Compound 
	{
		//internals
		static public const CALCULATE		:String = "Stats.CALCULATE";
		static public const DATA_REQUEST	:String = "Stats.DATA_REQUEST";
		static public const DRAW			:String = "Stats.DRAW";
		static public const UPDATE			:String = "Stats.UPDATE";
		static public const UPDATE_REALTIME	:String = "Stats.UPDATE_REALTIME";
		
		//in
		static public const START			:String = "Stats.START";
		static public const PAUSE			:String = "Stats.PAUSE";
		
		override public function init():void 
		{
			// modules required to run
			register(StageManager);
			
			// compound modules
			register(StatsData);
			register(StatsTransponder);
			register(StatsMonitorView);
			
			addBehaviour(Stats.CALCULATE, StatsCalculate);
		}
		
		override public function destroy():void 
		{
			sendSignal(Stats.PAUSE);
			
			removeBehaviour(Stats.CALCULATE);
			
			unregister(StageManager);
			
			unregister(StatsData);
			unregister(StatsTransponder);
			unregister(StatsMonitorView);
			
			super.destroy();
		}
	}

}