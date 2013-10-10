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
	 * This behaviour will simply generate provided amount of views. 
	 * As well as send signal about how much it took to do so.
	 * 
	 * Notice the register flag set to 'false'.
	 * By default registration of any component within BixBite is in singleton mode. 
	 * But this example is perfect demonstration that you may need to reuse 1 component multiple times.
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
			
			sendSignal("HelloWorld.TRACE", { trace:"Register Time of " + max +" HelloView " + (getTimer() - time) } ); 
			// NOTE!
			// emitSignal has been used, that will tell you one thing. 
			// You are in Compound channel and you can expect further action happens on the same channel.
			// So it can be taken over by any other behaviour or compound registered on the same core.
			emitSignal("HelloWorld.UPDATE_COPY", { isDefault:true } );
		}
	}
	
}