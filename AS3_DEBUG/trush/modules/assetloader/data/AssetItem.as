package com.accumulate.loaders 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class AssetItem implements IAsset
	{
		private var _name		:String;
		private var _source		:String;
		private var _type		:String;
		private var _content	:*;
		
		private var _initialised:Boolean = false;
		
		private var onComplete	:Function;
		private var onSkip		:Function;
		
		public var loaded		:Boolean = false; 
		public var loading		:Boolean = false;
		
		
		public function AssetItem(name:String, source:String, type:String)
		{
			_name = name;
			_source = source;
			_type = type;
		}
		
		public function load(onComplete:Function = null, onSkip:Function = null):void
		{
			this.onComplete = onComplete;
			this.onSkip 	= onSkip;
			
			if(!loaded){
				loading = true;
			} else {
				if (onComplete != null ) onComplete(this);
				return;
			}
		}
		
		public function itemLoaded(e:Event):void
		{
			loading = false;
			loaded = true;
			
			if (onComplete != null ) onComplete(this);
			
			clearCallbacks();
		}
		
		public function itemSkipped(e:IOErrorEvent):void
		{
			loading = false;
			loaded = false;
			
			if (onSkip != null ) onSkip(this);
			
			clearCallbacks();
		}
		
		public function isLoaded():Boolean
		{
			return (loaded) ? true : false;
		}
		
		public function isLoading():Boolean
		{
			return (loading) ? true : false;
		}
		
		public function isInitialised():Boolean
		{
			return (_initialised) ? true : false;
		}
		
		private function clearCallbacks():void 
		{
			this.onComplete = null;
			this.onSkip 	= null;
		}
		
		public function get name():String { return _name; };
		public function get source():String { return _source; }
		public function get type():String { return _type; }
		public function set content(value:*):void { _content = value };
		public function get content():* { return _content };
		public function set initialised(value:Boolean):void { _initialised = value; }
		
	}
}