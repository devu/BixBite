/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.data
{
	import examples.helloworld.HelloWorld;
	import org.bixbite.core.Data;
	import org.bixbite.core.Signal;
	
	/**
	 * @langversion	3.0
	 * 
	 * This Data component is a copy holder that will reponse to Compound on request being sent from Behaviour.
	 * Data component doesn't care who is calling, will respond as soon as a signal has been recieved.
	 *
	 * The main purpose od the Data component is to react on specific signal from Behaviour and response with Data set that provides.
	 */
	public class HelloData extends Data
	{
		public var english	:String = "<font color='#000000'> Hello world </font>";
		public var polish	:String = "<font color='#000000'> Witaj świecie </font>";
		public var french	:String = "<font color='#000000'> Bonjour tout le monde </font>";
		public var german	:String = "<font color='#000000'> Hallo Welt </font>";
		
		public function HelloData()
		{
		
		}
		
		override public function init():void
		{
			addSlot("HelloWorld.COPY_REQUEST", onCopyRequest);
		}
		
		private function onCopyRequest(s:Signal):void
		{
			responseTo(s.callerUID, "HelloWorld.COPY_REQUEST");
		}
		
		override public function destroy():void 
		{
			removeSlot("HelloWorld.COPY_REQUEST");
			super.destroy();
		}
	
	}

}