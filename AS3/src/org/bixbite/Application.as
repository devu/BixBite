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
	import org.bixbite.framework.UIManager;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	import org.bixbite.framework.Stats;
	import org.bixbite.framework.UIManager;
	
	
	/**
	 * Application x
	 */
	
	public class Application extends Sprite
	{
		private var mainCore	:Core;
		
		public function Application() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var bb:BixBite = new BixBite(stage);
			bb.addContextRoot("stage", stage);
			
			mainCore = bb.spawnCore("main");
			
			mainCore.register(StageManager);
			mainCore.emitSignal(StageSignal.SET_STAGE, { frameRate:30 } );
			
			//mainCore.register(Stats);
			//mainCore.emitSignal(Stats.START);
			
			mainCore.register(UIManager);
		}
		
	}

}