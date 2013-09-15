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

Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite 
{
	import examples.userinterface.HelloUIApp;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	import org.bixbite.framework.data.UIStyle;
	import org.bixbite.framework.signal.UISignal;
	import org.bixbite.framework.UIManager;
	import org.bixbite.framework.signal.StageSignal;
	import org.bixbite.framework.StageManager;
	import org.bixbite.framework.Stats;
	import org.bixbite.framework.UIManager;
	
	/**
	 * Application
	 * 'Think, cores and modules management'
	 * 
	 * Application is just an document root, starting point when you hook up BixBite framework with your target platform.
	 * Define cores, point to the root of display layer and register Compounds within. 
	 * By emiting a signals on core you can set initial states of your Modules/Compounds.
	 * 
	 * In practice your Modules can start itself from inside, but it is for better clarity of the code. 
	 * So you can easly follow what each module is doing and when.
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
			
			//instance of BixBite
			var bb:BixBite = new BixBite(stage);
			
			//declare displayable root of your application. You can have multiple roots.
			bb.addContextRoot("app", this);
			
			//spawn a core
			mainCore = bb.spawnCore("main");
			
			// register modules and fire initial signals
			mainCore.register(StageManager);
			mainCore.emitSignal(StageSignal.SET_STAGE, { frameRate:60 } );
			
			mainCore.register(Stats);
			mainCore.emitSignal(Stats.START);
			
			mainCore.register(UIManager);
			mainCore.emitSignal(UISignal.INIT);
			
			//or
			
			/*
			mainCore.register(UIManager);
			var uiStyle:UIStyle = new UIStyle();
			uiStyle.canvasColor = 0xFF9988;
			mainCore.emitSignal(UISignal.INIT, { style:uiStyle } );
			*/
			
			//and finally the module you are working on
			mainCore.register(HelloUIApp);
			mainCore.emitSignal(HelloUIApp.INIT);
		}
		
	}

}