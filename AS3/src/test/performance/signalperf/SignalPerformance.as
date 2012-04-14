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

package test.performance.signalperf 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.stageManager.StageManager;
	import org.bixbite.framework.modules.stats.Stats;
	import test.performance.signalperf.behaviour.TestBehaviour;
	import test.performance.signalperf.behaviour.TestRunner;
	import test.performance.signalperf.transponder.TestTransponder;
	import test.performance.signalperf.view.TestView;
	
	/**
	 * @version  compatibility - 0.5.0
	 * @since 0.4.2
	 * footprint 8.92kb
	 * 
	 * Subject of this test is to check performance of the current BixBite signal flow implementation.
	 * 
	 * 1 Phase
	 * On mouse click Transponder will send signal to Atom and Atom will respond to View.
	 * This is just initial flow test. Making sure Components can talk to each other.
	 * 
	 * 2 Phase
	 * Once 1 Phase is finished View will send X number of times signals going through full triade following the flow:
	 * View -> Transponder -> Atom -> View. When finish will send signal to Stats to display results.
	 * 
	 * Results (Flash Player 11,1,102,63 - Chrome)
	 * Signals traveling from View -> Transponder -> Atom -> View.
	 * 
	 * v0.5.0 SRS
	 * 1.000 		- no time:)	(3k signals in circulation)
	 * 10.000 		- 0.9ms		(30k signals in circulation)
	 * 100.000		- 9ms		(300k signals in circulation)
	 * 1.000.000	- 94ms		(3M signals in circulation)
	 * 10.000.000	- 948ms		(30M signals in circulation)
	 * 
	 * v0.5.0
	 * 1.000 		- 1			(3k signals in circulation)
	 * 10.000 		- 12ms		(30k signals in circulation)
	 * 100.000		- 125ms		(300k signals in circulation)
	 * 1.000.000	- 1289ms	(3M signals in circulation)
	 * 
	 * v0.4.4 SRS in use!
	 * 1.000 		- no time:)	(3k signals in circulation)
	 * 10.000 		- 1ms		(30k signals in circulation)
	 * 100.000		- 9ms		(300k signals in circulation)
	 * 1.000.000	- 99ms		(3M signals in circulation)
	 * 10.000.000	- 931ms		(30M signals in circulation)
	 *
	 * v0.4.4 - No changes
	 * 
	 * v0.4.3
	 * 1.000 		- 1ms		(3k signals in circulation)
	 * 10.000 		- 13ms		(30k signals in circulation)
	 * 100.000		- 133ms		(300k signals in circulation)
	 * 1.000.000	- 1325ms	(3M signals in circulation)
	 * 
	 * v0.4.2
	 * 1.000 		- 2ms		(3k signals in circulation)
	 * 10.000 		- 22ms		(30k signals in circulation)
	 * 100.000		- 207ms		(300k signals in circulation)
	 * 1.000.000	- 2120ms	(3M signals in circulation)
	 * 
	 */
	public class SignalPerformance extends Compound
	{
		
		public function SignalPerformance() 
		{
			var stageManager	:StageManager = new StageManager();
			var stats			:Stats = new Stats();
			stats.enableTracer();
			
			var t:TestTransponder 	= new TestTransponder();
			var v:TestView 			= new TestView();
			
			addBehaviour(Signals.START_TEST	, TestBehaviour);
			addBehaviour(Signals.RUN_TEST	, TestRunner);
			
			startup(Signals.INIT_TEST);
		}
		
	}

}