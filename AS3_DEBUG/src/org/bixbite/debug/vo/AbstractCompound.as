package org.bixbite.debug.vo 
{
	import flash.utils.Dictionary;
	import org.bixbite.debug.ui.HexWindow;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AbstractCompound extends AbstractComponent
	{
		public var mc			:HexWindow;
		
		public var compounds	:Dictionary = new Dictionary();
		
		public var behaviours	:Dictionary = new Dictionary();
		public var datas		:Dictionary = new Dictionary();
		public var trans		:Dictionary = new Dictionary();
		public var views		:Dictionary = new Dictionary();
		
		public function AbstractCompound(name:String, mc:HexWindow) 
		{
			super(name);
			this.mc = mc;
		}
		
	}

}