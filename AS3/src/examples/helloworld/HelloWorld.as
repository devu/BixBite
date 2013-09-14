/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld 
{
	import examples.helloworld.behaviour.CopyHandler;
	import examples.helloworld.behaviour.Initialise;
	import examples.helloworld.data.HelloData;
	import examples.helloworld.transponder.HelloTransponder;
	import examples.helloworld.view.Output;
	import org.bixbite.core.Compound;
	
	/**
	 * @langversion	3.0
	 */
	public class HelloWorld extends Compound 
	{
		public function HelloWorld() 
		{
			
		}
		
		override public function init():void 
		{
			register(HelloTransponder);
			register(HelloData);
			register(Output);
			
			addBehaviour("HelloWorld.UPDATE_COPY", CopyHandler);
			addBehaviour("HelloWorld.INIT", Initialise);
			
			emitSignal("HelloWorld.INIT", { max:1000 } );
		}
		
	}

}