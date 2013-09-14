/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package test.performance.coreperf.behaviour 
{
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	
	/**
	 * @langversion	3.0
	 */
	public class TraceOutput extends Behaviour 
	{
		private var outputData:Array;
		
		public function TraceOutput() 
		{
			
		}
		
		override public function init():void 
		{
			outputData = [];
		}
		
		override public function execute(s:Signal):void 
		{
			outputData[s.params.id] = s.params;
			
			var output:String = "";
			for each(var data:Object in outputData) output += data.row + "\n";
			
			sendSignal("traceOutput", output );
		}
		
	}

}