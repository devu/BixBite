package test.performance.coreperf.view.context 
{
	import org.bixbite.framework.view.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class TestViewCContext extends Context 
	{
		
		public function TestViewCContext() 
		{
			graphics.beginFill(0x000FFF, 1);
			graphics.drawRect(0, 0, 100, 100);
		}
		
		override public function dispose():void 
		{
			graphics.clear();
		}
		
	}

}