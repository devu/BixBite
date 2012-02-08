package org.bixbite.framework
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	import org.bixbite.framework.core.Signal;
	import org.bixbite.framework.interfaces.*;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Bixbite implements IBixbite
	{	
		private static var _instance:Bixbite = new Bixbite();
		
		private var _assets	:IAssetsLoader;
		private var _gl		:IGraphicsFactory;
		
		private var signals	:Dictionary = new Dictionary();
		
		public function Bixbite()
		{
			
		}
		
		/**
		 * 
		 * @param	graphicsFactory
		 * @param	assetsLoader
		 */
		public function init(graphicsFactory:IGraphicsFactory = null, assetsLoader:IAssetsLoader = null):void
		{
			_gl 	= graphicsFactory;
			_assets = assetsLoader;
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 * @param	callback
		 */
		public function attachSignal(caller:IActor, type:String, callback:Function):void
		{
			if (!signals[type])
				signals[type] = new Signal();
			Signal(signals[type]).add(caller, callback);
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 */
		public function detachSignal(caller:IActor, type:String):void
		{
			Signal(signals[type]).remove(caller);
		}
		
		/**
		 * 
		 * @param	target
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(target:IActor, type:String, params:IValueObject = null):void
		{
			if (signals[type])
				Signal(signals[type]).dispatchTo(target, params);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:IValueObject = null):void
		{
			if (signals[type])
				Signal(signals[type]).dispatch(params);
		}
		
		/**
		 * Getters / Setters
		 */
		static public function get instance():Bixbite { return _instance; }
		
		//read only
		public function get gl():IGraphicsFactory { return _gl; }		
		public function get assets():IAssetsLoader { return _assets; }
	}

}