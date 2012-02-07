package org.bixbite.framework 
{
	import org.bixbite.framework.Bixbite;
	import org.bixbite.framework.core.View;
	import org.bixbite.framework.interfaces.IApplication;
	import org.bixbite.framework.interfaces.IAssetsLoader;
	import org.bixbite.framework.interfaces.IGraphicsFactory;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Application extends View implements IApplication
	{
		public function Application(graphicsFactory:IGraphicsFactory = null, assetsLoader:IAssetsLoader = null) 
		{
			Bixbite.instance.init(stage, graphicsFactory, assetsLoader);
		}
		
		override public function create():void 
		{
			stage.align 	= "TL";
			stage.scaleMode = "noScale";
		}
		
	}

}