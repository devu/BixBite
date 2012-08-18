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
	import org.bixbite.framework.behaviour.Calculate;
	import org.bixbite.framework.data.StatsData;
	import org.bixbite.framework.transponder.StatsTransponder;
	import org.bixbite.framework.view.StatsMonitorView;
	import org.bixbite.framework.signal.StatsSignal;
	import org.bixbite.namespaces.STATS;
	
	/**
	 * @langversion	3.0
	 * 
	 * This is fork of stats by mrdoob implemented within BixBite framework.
	 * 
	 */
	public class Stats extends Compound 
	{
		use namespace STATS
		
		STATS static const CALCULATE		:String = "Stats.CALCULATE";
		STATS static const DATA_REQUEST		:String = "Stats.DATA_REQUEST";
		STATS static const DRAW				:String = "Stats.DRAW";
		STATS static const UPDATE			:String = "Stats.UPDATE";
		STATS static const UPDATE_REALTIME	:String = "Stats.UPDATE_REALTIME";
		
		/**
		 * Constructor
		 */
		public function Stats() 
		{
			
		}
		
		override public function init():void 
		{
			// modules required to run
			register(DisplayListManager);
			register(StageManager);
			
			// compound modules
			register(StatsData);
			register(StatsTransponder);
			register(StatsMonitorView);
			
			addBehaviour(Stats.CALCULATE, Calculate);
		}
		
		override public function destroy():void 
		{
			sendSignal(StatsSignal.PAUSE);
			
			removeBehaviour(Stats.CALCULATE);
			
			unregister(DisplayListManager);
			unregister(StageManager);
			
			unregister(StatsData);
			unregister(StatsTransponder);
			unregister(StatsMonitorView);
			
			super.destroy();
		}
	}

}