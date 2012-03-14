package org.bixbite.examples.stats.signal 
{
	import org.bixbite.core.Signal;
	
	/**
	 * ...
	 */
	public class TraceSignal extends Signal 
	{
		public var name		:String;
		public var value	:String;
		public var line		:int;
		
		public function TraceSignal(name:String, value:*, line:int = 0) 
		{
			this.name = name;
			this.value = value.toString();
			this.line = line;
		}
		
		override public function dispose():void 
		{
			super.dispose();
			
			this.name = null;
			this.value = null;
			this.line = NaN;
		}
		
	}

}