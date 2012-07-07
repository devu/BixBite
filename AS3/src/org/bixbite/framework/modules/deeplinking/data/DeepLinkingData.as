package org.bixbite.framework.modules.deeplinking.data 
{
	import flash.external.ExternalInterface;
	import flash.utils.setInterval;
	import org.bixbite.core.Data;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.modules.deeplinking.DeepLinking;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class DeepLinkingData extends Data 
	{
		private var movieID		:String;
		
		public var location		:Location;
		
		public function DeepLinkingData() 
		{
			
		}
		
		override public function init():void 
		{
			trace(this, "init");
			
			location = new Location();
			
			addSlot(DeepLinking.INIT_JS_API, onInitAPI);
		}
		
		private function onInitAPI(s:ISignal):void 
		{
			movieID = s.params[0];
			
			trace(this, "onInitialiseAPI " + movieID);
			
			if (ExternalInterface.available){
				setJSAPI();
			} else {
				trace("sandbox");
			}
		}
		
		private function setJSAPI():void
		{
			ExternalInterface.addCallback("updateLocation", onLocationUpdated);
			
			var initialiser:XML = 
			<script>
				<![CDATA[
					function(movieName) {
						
						console.log(movieName);
						
						thisMovie = function thisMovie(movieName) {
							if (navigator.appName.indexOf("Microsoft") != -1) {
								return window[movieName];
							} else {
								return document[movieName];
							}
						}
						
						locationHashChanged = function(){
							thisMovie(movieName).updateLocation(window.location);
						}
					  
						window.onhashchange = locationHashChanged;  
					}
				]]>
			</script>
			
			ExternalInterface.call(initialiser, movieID);
			ExternalInterface.call("locationHashChanged");
		}
		
		private function onLocationUpdated(data:Object):void 
		{
			location.cast(data);
			trace("flash -> onLocationUpdated", location.toString());
			
			sendSignal(DeepLinking.ON_CHANGE, [this]);
		}
		
	}

}

internal class Location
{
	public var hash		:String;
	public var href		:String;
	public var host		:String;
	public var hostname	:String;
	public var pathname	:String;
	public var port		:String;
	public var protocol	:String;
	public var search	:String;
	
	public function Location()
	{
		
	}
	
	public function cast(object:Object):void
	{
		this.hash		= object.hash;
		this.href		= object.href;
		this.host		= object.host;
		this.hostname	= object.hostname;
		this.pathname	= object.pathname;
		this.port		= object.port;
		this.protocol	= object.protocol;
		this.search		= object.search;
	}
	
	public function toString():String
	{
		return 	"\n hash [ " + hash + " ]" + 
				"\n href [ " + href + " ]" + 
				"\n host [ " + host + " ]" + 
				"\n hostname [ " + hostname + " ]" +
				"\n pathname [ " + pathname + " ]" +
				"\n port [ " + port + " ]" +
				"\n protocol [ " + protocol + " ]" +
				"\n search [ " + search + " ]\n";
	}
}