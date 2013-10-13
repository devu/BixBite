/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.integration.leaktest 
{
	
	import org.bixbite.core.Compound;
	import test.integration.leaktest.behaviour.LeakTestInit;
	import test.integration.leaktest.behaviour.LeakTestTerminate;
	import test.integration.leaktest.data.LeakTestData;
	import test.integration.leaktest.transponder.LeakTestTransponder;
	import test.integration.leaktest.view.LeakTestView;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class LeakTest extends Compound 
	{
		override public function init():void 
		{
			register(LeakTestData);
			register(LeakTestTransponder);
			register(LeakTestView);
			
			addBehaviour("LeakTest.INIT", LeakTestInit, true);
			addBehaviour("LeakTest.TERMINATE", LeakTestTerminate);
		}
		
		override public function destroy():void
		{
			unregister(LeakTestData);
			unregister(LeakTestTransponder);
			unregister(LeakTestView);
			
			//removeBehaviour("LeakTest.INIT");// it has been automaticaly disposed
			removeBehaviour("LeakTest.TERMINATE");
			
			super.destroy();
		}
		
	}
	
}