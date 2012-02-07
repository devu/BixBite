package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.sampler.getSize;
	import org.bixbite.framework.Application;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Main extends Application 
	{
		
		public function Main():void
		{
			
		}
		
		override public function init():void 
		{
			trace("MEM USAGE", getSize(this));
		}
		
	}
	
}