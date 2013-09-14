/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.behaviour 
{
	
	import examples.helloworld.view.HelloView;
	import flash.utils.getTimer;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class Initialise extends Behaviour 
	{
		override public function execute(s:Signal):void
		{
			var max:int = s.params.max;
			var time:int = getTimer();
			
			for (var i:int = 0; i < max; i++) {
				register(HelloView, false);
			};
			
			sendSignal("Trace", { trace:"Register Time of " + max +" HelloView " + (getTimer() - time) } ); 
			emitSignal("HelloWorld.UPDATE_COPY", { isDefault:true } );
		}
	}
	
}