/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.behaviour 
{
	import examples.helloworld.data.HelloData;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * @langversion	3.0
	 * This behaviour will deal with our copy. It is a business logic part of our little app.
	 * It is a bridge between data we store our values in, and actual state of it.
	 * So, on initialisation this behaviour will request access to data to get ready before any execution.
	 */
	public class CopyHandler extends Behaviour 
	{
		private var copy		:HelloData;
		
		private var languages	:Array;
		private var lang		:int = 1;
		
		override public function init():void 
		{
			languages = [];
			languages[0] = "english";
			languages[1] = "polish";
			languages[2] = "french";
			languages[3] = "german";
			
			addResponder("HelloWorld.COPY_REQUEST", onCopyData, true);
		}
		
		private function onCopyData(data:HelloData):void
		{
			copy = data;
		}
		
		override public function execute(s:Signal):void 
		{
			var isDefault:Boolean = s.params.isDefault;
			
			if (isDefault){
				sendSignal("HelloWorld.SET_COPY", { copy:copy.english } );
				return
			}
			
			var copyString:String;
			
			switch(languages[lang])
			{
				case "english":
					copyString = copy.english;
					break;
				case "polish":
					copyString = copy.polish;
					break;
				case "french":
					copyString = copy.french;
					break;
				case "german":
					copyString = copy.german;
					break;
			}
			
			sendSignal("HelloWorld.SET_COPY", { copy:copyString } );
			
			if (lang < 3){
				lang++;
			} else {
				lang = 0;
			}
		}
		
	}

}