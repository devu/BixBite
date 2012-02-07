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
		
		private var stage	:Stage;
		private var signals	:Dictionary = new Dictionary();
		
		public function Bixbite()
		{
			_instance = this;
		}
		
		/**
		 * 
		 * @param	stage
		 * @param	graphicsFactory
		 * @param	assetsLoader
		 */
		public function init(stage:Stage, graphicsFactory:IGraphicsFactory = null, assetsLoader:IAssetsLoader = null):void
		{
			this.stage 	= stage;
			this.gl 	= graphicsFactory;
			this.assets = assetsLoader;
		}
		
		/**
		 * 
		 * @param	caller
		 * @param	type
		 * @param	callback
		 */
		public function addSignal(caller:IActor, type:String, callback:Function):void
		{
			if (!signals[type])
				signals[type] = new Signal();
			Signal(signals[type]).add(caller, callback);
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
			else
				trace("signal", type, " is not registered");
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
			else
				trace("signal", type, " is not registered");
		}
		
		/**
		 * Getters / Setters
		 */
		static public function get instance():Bixbite { return _instance; }
		
		public function get gl():IGraphicsFactory { return _gl; }
		public function set gl(value:IGraphicsFactory):void { _gl = value; }
		
		public function get assets():IAssetsLoader { return _assets; }
		public function set assets(value:IAssetsLoader):void { _assets = value; }
	}

}