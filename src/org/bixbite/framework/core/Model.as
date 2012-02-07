package org.bixbite.framework.core 
{
	import flash.errors.IllegalOperationError;
	import org.bixbite.framework.Bixbite;
	import org.bixbite.framework.interfaces.IAssetsLoader;
	import org.bixbite.framework.interfaces.IModel;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 * 
	 * MODEL
	 * 
	 * <b>Purpose:</b>
	 * Contains the application DATA and BUSINESS LOGIC to manage the STATE of the application
	 * 
	 * <b>Quote:</b>
	 * According to the standard model billions of years ago some little quantum fluctuation, perhaps a slightly
	 * lower density of matter, maybe right where we’re sitting right now, caused our galaxy to start collapsing around here.
	 * —Seth Lloyd
	 * 
	 * <b>Implementation:</b>
	 * Abstract Class extends Actor
	 */
	
	public class Model extends Actor implements IModel
	{
		private var _assets:IAssetsLoader;
		
		public function Model() 
		{
			if (Object(this).constructor == Model)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
				
			_assets = Bixbite.instance.assets;
		}
		
		/**
		 * Getters / Setters
		 */
		public function get assets():IAssetsLoader { return _assets; }
	}

}