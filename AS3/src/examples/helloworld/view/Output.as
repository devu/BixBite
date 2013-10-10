/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package examples.helloworld.view 
{
	
	import flash.text.TextField;
	import org.bixbite.core.Context;
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class Output extends View 
	{
		private var root:Context;
		private var tf:TextField;
		
		override public function init():void 
		{
			tf = new TextField();
			tf.autoSize = "left";
			root = getContext("app");
			root.body.addChild(tf);
			
			addSlot("Trace", onTrace);
		}
		
		private function onTrace(s:Signal):void 
		{
			tf.text = s.params.trace;
		}
		
	}
	
}