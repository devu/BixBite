/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.userinterface 
{
	
	import org.bixbite.core.Compound;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.behaviour.UIAppInit;
	import org.bixbite.framework.signal.UISignal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class HelloUIApp extends Compound 
	{
		static public const INIT:String = "HelloUIApp.INIT";
		
		override public function init():void 
		{
			trace(this, "init");
			
			emitSignal(UISignal.CREATE_PANEL, { x:0, y:100, w:'100%', h:100 } );
			
			addBehaviour(HelloUIApp.INIT, UIAppInit);
		}
		
		override public function destroy():void
		{
			//clean up this class here and then:
			super.destroy();
		}
		
	}
	
}