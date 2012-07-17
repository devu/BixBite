package org.bixbite.debug.vo 
{
	import org.bixbite.debug.ui.HexListItem;
	import org.bixbite.debug.ui.HexWindow;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AbstractBehaviour extends AbstractComponent
	{
		public var exeCount	:int = 0;
		public var signal	:String;
		public var mc		:HexListItem;
		
		public function AbstractBehaviour(name:String, mc:HexListItem) 
		{
			super(name);
			this.mc = mc;
		}
		
		public function execute():void
		{
			exeCount++;
			mc.counter = exeCount;
		}
		
	}

}