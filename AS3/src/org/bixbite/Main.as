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
	import org.bixbite.core.Application;
	import org.bixbite.framework.modules.stats.Stats;
	import org.bixbite.framework.transponder.StageTransponder;
	import org.bixbite.framework.view.StageView;
	
	/**
	 * @version 0.4.5
	 * total footprint 8.20kb
	 * 
	 * Main Bixbite frmework class for development purposes.
	 * Contains collection of framework modules.
	 * 
	 * TODO
	 * 0.4.6
	 * -each actor specific methods to access system, remove systemIO.
	 * 0.4.7
	 * - signals try multi attachSignal by id.
	 * 
	 * LOG:
	 * 0.4.5 
	 * - Controller renamed to Transponder to indicate its proper role
	 * - Constants fro signal types.
	 * 0.4.4
	 * - signal channels implemented MVC (specific routes)
	 */
	public class Main extends Application
	{
		
		public function Main() 
		{
			var stageTrans	:StageTransponder 	= new StageTransponder();
			var stageView	:StageView 			= new StageView();
			
			var stats		:Stats 				= new Stats(stageView, false);
		}
		
	}

}