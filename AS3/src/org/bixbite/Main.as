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

	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	import org.bixbite.framework.Stats;
	import test.performance.signalperf.SignalPerformance;
	
	/**
	 * Main BixBite frmework document class for development purposes
	 * 
	 * footprint 3.03kb (signle core); +0.02kb per additional core
	 * 
	 * Dev Notes
	 * 
	 * Next milestone 0.9.0
	 * - cross core communication (Multithreading-like architucture w/o Workers when each core has its own set of signals/slots and components)
	 * - AS3 workers will also have a go. That will be final step and this microarchitecture complete. I am very happy with the overal structure now.
	 * Having Strongly Typed SRS and linked list for Slot implemented was the biggest problem I was trying to solve in elegant way.
	 * 
	 * Before it will reach 1.0.0 all iteration will be about compatibility tests, bug fixing, etc. No further changes to the core after that.
	 * But before we hit 0.9.0 I need to do the same with the current 0.8.0 version :) stay tuned.
	 */
	
	public class Main extends Sprite
	{
		private var core1:Core;
		private var core2:Core;
		
		public function Main() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var bb:BixBite = new BixBite(stage);
			
			core1 = bb.spawnCore("1");
			
			core1.register(StageManager);
			core1.sendSignal(StageSignal.SET_STAGE, { frameRate:30 } );
			
			core1.register(Stats);
			core1.sendSignal(Stats.START);
			
			core2 = bb.spawnCore("2");
			core2.register(SignalPerformance);
		}
		
	}

}