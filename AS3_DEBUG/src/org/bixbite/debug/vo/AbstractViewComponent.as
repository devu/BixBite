package org.bixbite.debug.vo 
{
	import org.bixbite.debug.ui.HexWindow;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AbstractViewComponent extends AbstractComponent
	{
		public var mc		:HexWindow;
		
		public function AbstractViewComponent(name:String, mc:HexWindow) 
		{
			super(name);
			this.mc = mc;
		}
		
		override public function markAsDuplicate():void 
		{
			super.markAsDuplicate();
			mc.duplicated();
		}
		
	}

}