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
	
	/**
	 * Main BixBite frmework document class for development purposes
	 * 
	 * footprint 3.41kb (signle core);
	 * 
	 * Dev Notes
	 * Before it will reach 1.0.0 all iteration will be about compatibility tests, bug fixing, etc. No further dramatic changes to the core after that.
	 */
	
	public class Main extends Sprite
	{
		private var core1:Core;
		
		public function Main() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var bb:BixBite = new BixBite(stage);
			core1 = bb.spawnCore("1");
			/*
			core1.register(StageManager);
			core1.sendSignal(StageSignal.SET_STAGE, { frameRate:30 } );
			
			core1.register(Stats);
			core1.sendSignal(Stats.START);
			
			core2 = bb.spawnCore("2");
			core2.register(SignalPerformance);*/
		}
		
	}

}