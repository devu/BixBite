/**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~88888888888~~~~88888~~88888~~~~888~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~88888~~~88888~~~8888~~~~8888~~888~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~8888~~~~88888~~88888~~~~8888888~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~888888888888~~~~8888~~~~~~88888~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~88888~~~~88888~~88888~~~~~~88888~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~88888~~~~88888~~8888~~~~~8888888~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~88888~~~~88888~~88888~~~888~~88888~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~777~~~~~~8888888888888~~~88888~~888~~~~~88888~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~7777$~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~777$$$$$$~~~~~~~~~~~~~~~~~~~~88888888888~~~~88888~~8888888888~~88888888888~~
~~~7$$$$$$$$$$$$~~~~~~~~~~~~~~~~88888~~~88888~~~8888~~~~~88888~~~~888888~~~~~~~~
~~$$$$$$$$$$$$$$????????~~~~~~~~8888~~~~88888~~88888~~~~~8888~~~~~88888~~~~~~~~~
~~&&$$$$$$$$$$$$????????~~~~~~~888888888888~~~~8888~~~~~88888~~~~8888888888~~~~~
~~~&&&$$$$$$$$$??????????~~~~~88888~~~~88888~~88888~~~~~8888~~~~~88888~~~~~~~~~~
~~~&&&&&&$$$$$$??????????~~~~~88888~~~~88888~~8888~~~~~88888~~~~88888~~~~~~~~~~~
~~~~&&&&&&&$$$????????????~~~88888~~~~88888~~88888~~~~88888~~~~~8888888888~~~~~~
~~~~&&&&&&&&&+++++++++++~~~~8888888888888~~~88888~~~~~88888~~~~88888888888~~~~~~
~~~~~&&&&&&&++++++++++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~&&&&&++++++++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~&&&+++++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~&+++~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The MIT License

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
	import com.sociodox.theminer.TheMiner;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.bixbite.core.BixBite;
	import org.bixbite.framework.DisplayListManager;
	import org.bixbite.framework.signal.StatsSignal;
	import org.bixbite.framework.Stats;
	import org.bixbite.framework.YTPlayer;
	//import flash.events.MouseEvent;
	//import flash.system.System;
	//import org.bixbite.framework.DisplayListManager;
	//import org.bixbite.framework.signal.StatsSignal;
	//import org.bixbite.framework.StageManager;
	//import org.bixbite.framework.Stats;
	
	/**
	 * @version 0.6.1
	 * 
	 * Main BixBite frmework document class for development purposes.
	 * Contains a core of the framework.
	 * 
	 * footprint 2.92kb
	 * 
	 */
	
	public class Main extends Sprite
	{
		private var core	:BixBite;
		
		//private var step	:int = 0;
		//private var round	:int = 0;
		
		public function Main() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//var miner:TheMiner = new TheMiner();
			//miner.x = 400;
			//addChild(miner);
			
			core = new BixBite(stage);
			
			//youtube player
			//core.register(YTPlayer);
			//core.sendSignal(YTPlayer.INIT, { videoId:"mN3ITf_gn0g" } );
			
			//core.register(Stats);
			//core.sendSignal(StatsSignal.START);
		}
		
		/*
		private function nextStep(e:Event):void 
		{
			var t:int = getTimer();
			
			step++;
			
			switch(step)
			{
				case 1:
					//Framework
					core = new BixBite(stage);
					trace("create BixBite", getTimer()-t);
					break;
				case 4:
					//DisplayListManager Module
					core.register(DisplayListManager);
					trace("create DisplayListManager", getTimer()-t);
					break;
				case 7:
					//StageManager Module
					core.register(StageManager);
					trace("create StageManager", getTimer()-t);
					core.sendSignal(StageSignal.SET_STAGE, { align:"TL", scaleMode:"noScale" } );
					break;
				case 10:
					 //Stats Module
					core.register(Stats);
					trace("create Stats", getTimer()-t);
					core.sendSignal(StatsSignal.START);
					break;
				case 13:
					core.unregister(DisplayListManager);
					trace("unregister DisplayListManager", getTimer() - t);
					break;
				case 16:
					core.unregister(StageManager);
					trace("unregister StageManager", getTimer()-t);
					break;
				case 19:
					core.unregister(Stats);
					trace("unregister Stats", getTimer()-t);
					break;
				case 22:
					
					if (round < 10) {
						trace("---reset---", round);
						step = 3;
					} else {
						Emiter.getInstance();
					}
					
					round++;
					
					break;
				default:
					System.gc();
					trace("System.gc", System.totalMemory / 1024, getTimer()-t);
					break;
				
			}
		}*/
		
	}

}