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

package org.bixbite.examples.stats 
{
	import org.bixbite.core.Application;
	import org.bixbite.examples.stats.controller.StatsController;
	import org.bixbite.examples.stats.model.StatsModel;
	import org.bixbite.examples.stats.view.StatsView;
	import org.bixbite.framework.controller.StageController;
	
	/**
	 * @version  compatibility - 0.4.1
	 * footprint 7.11kb
	 * 
	 * This is example of how famous stats by mrdoob can be implemented within Bixbite mvc framework.
	 * It is also a fork of my fork, MobileStats.as.
	 * 
	 * IMPORTANT: This is just an example to show a flow, do not use it for development purposes.
	 * There will be proper optimised version provided as a functional module as a part of framework.
	 */
	public class MainStats extends Application 
	{
		/**
		 * Constructor, set a triad (StageController is a temporary controller if this project runs as independend Application. 
		 * In fact Stats by nature will run as module always, so they can use already added StageController.
		 */
		public function MainStats() 
		{
			//For presentaion purposes only
			var stageCtrl:StageController = new StageController();
			
			//Set of actors needed to perform this task.
			var m:StatsModel 		= new StatsModel();
			var v:StatsView 		= new StatsView();
			var c:StatsController 	= new StatsController();
			
			// If you will study this example, you can quickly recognise posibilities that Bixbite opens.
			// You can easly replace any of the actor with your own implementation. 
			// More likely create diferent sets of Views that displays same set od data diferent way. 
			// Classes are loosly coupled so you will not breake any dependanices at all.
		}
		
	}

}