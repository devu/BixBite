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

package org.bixbite 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.stageManager.StageManager;
	import org.bixbite.framework.modules.stats.Stats;
	
	/**
	 * @version 0.5.0
	 * footprint 7.88kb; (8.20kb for v0.4.5) StageManager + Stats
	 * 
	 * Main Bixbite frmework class for development purposes.
	 * Contains collection of framework modules.
	 * 
	 * TODO
	 * 0.5.1
	 * - more integration and performance tests
	 * 0.5.0
	 * - rebuild docs, libs, modules and all examples based on new architecture.
	 * 
	 * LOG:
	 * 0.4.9
	 * - Behaviour mechanism and communication model
	 * - no need for bi-directional communication
	 * 0.4.8
	 * - Move away from MVC pattern
	 * - Compound Crystal Pattern name conventions
	 * - Attach Signal obsolete, no more reatachment
	 * - Signals are no longer value objects, use Data Components instead to carry informations
	 * 0.4.7
	 * - Model divided to Atom and Data components
	 * - Improved communication model.
	 * - response/request
	 * 0.4.6
	 * -each actor specific methods to access system, remove systemIO.
	 * 0.4.5 
	 * - Controller renamed to Transponder to indicate its proper role
	 * - Constants for signal types.
	 * 0.4.4
	 * - signal channels implemented(MVC specific routes)
	 */
	public class Main extends Compound
	{
		
		public function Main() 
		{
			var stageManager	:StageManager 	= new StageManager();
			var stats			:Stats 			= new Stats();
		}
		
	}

}