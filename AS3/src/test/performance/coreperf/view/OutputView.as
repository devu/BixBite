/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.coreperf.view 
{
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.view.context.OutputContext;
	
	/**
	 * @langversion	3.0
	 */
	public class OutputView extends View 
	{
		private var output:OutputContext;
		
		override public function init():void 
		{
			output = OutputContext(registerContext("outputText", new OutputContext()));
			output.gl.move(110,0);
			getContext("debug").addChild(output);
			
			addSlot("traceOutput", onTraceOutput);
		}
		
		private function onTraceOutput(s:Signal):void 
		{
			output.text = String(s.params);
		}
		
	}

}