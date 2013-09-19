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
			
			emitSignal(UISignal.CREATE_PANEL, { name:"panel1", x:0, y:100, width:'100%', height:'50', margin:[10,10,10,10] } );
			/*
			emitSignal(UISignal.CREATE_PANEL, { name:"panel2", x:10, y:20, width:80, height:50, container:"panel1" } );
			emitSignal(UISignal.CREATE_PANEL, { name:"panel3", x:100, y:250, width:10, height:50 } );
			emitSignal(UISignal.CREATE_PANEL, { name:"panel4", x:20, y:300, width:40, height:50 } );
			*/
			addBehaviour(HelloUIApp.INIT, UIAppInit);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
	}
	
}