package org.bixbite.framework 
{
	import org.bixbite.framework.core.View;
	import org.bixbite.framework.interfaces.IApplication;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Application extends View implements IApplication
	{
		public function Application() 
		{
			
		}
		
		override public function create():void 
		{
			stage.align 	= "TL";
			stage.scaleMode = "noScale";
		}
		
	}

}