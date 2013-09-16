/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.coreperf.view 
{
	import org.bixbite.core.Signal;
	import org.bixbite.core.View;
	import org.bixbite.framework.view.context.OutputContext;
	
	/**
	 * @langversion	3.0
	 */
	public class OutputView extends View 
	{
		private var output		:OutputContext;
		
		override public function init():void 
		{
			output = OutputContext(registerContext("outputText", OutputContext));
			output.y = 110;
			getContainer("app").add(output);
			
			addSlot("traceOutput", onTraceOutput);
		}
		
		private function onTraceOutput(s:Signal):void 
		{
			output.text = String(s.params);
		}
		
	}

}