package org.bixbite.debug.vo 
{
	import org.bixbite.debug.ui.HexWindow;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AbstractDataComponent extends AbstractComponent
	{
		public var mc		:HexWindow;
		
		public function AbstractDataComponent(name:String, mc:HexWindow) 
		{
			super(name);
			this.mc = mc;
		}
		
	}

}