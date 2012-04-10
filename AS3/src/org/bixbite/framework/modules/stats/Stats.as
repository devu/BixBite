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

package org.bixbite.framework.modules.stats 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.stats.behaviour.Calculate;
	import org.bixbite.framework.modules.stats.data.StatsData;
	import org.bixbite.framework.modules.stats.transponder.StatsTransponder;
	import org.bixbite.framework.modules.stats.view.StatsMonitor;
	import org.bixbite.framework.signals.StatsSignal;
	
	/**
	 * @version  compatibility - 0.5.0
	 * @since 0.4.1
	 * footprint ~ 7.19kb
	 * 
	 * This is fork of stats by mrdoob implemented within Bixbite framework.
	 * 
	 */
	public class Stats extends Compound 
	{
		/**
		 * Constructor, set a functional triad, modules and behaviours.
		 */
		public function Stats() 
		{
			var m:StatsData 		= new StatsData();
			var v:StatsMonitor 		= new StatsMonitor();
			var c:StatsTransponder 	= new StatsTransponder();
			
			stageView.addView(v);
			
			addBehaviour(StatsSignal.CALCULATE, Calculate);
		}
		
	}

}