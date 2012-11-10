package org.bixbite.core 
{
	import org.bixbite.namespaces.BIXBITE;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Core 
	{
		use namespace BIXBITE;
		
		BIXBITE var emiter		:Emiter;
		BIXBITE var uid			:String;
		BIXBITE var channelC	:Channel;
		BIXBITE var channelT	:Channel;
		
		public var signal		:Signal;
		
		public function Core(id:String) 
		{
			trace("core" + id);
			
			emiter = new Emiter();
			emiter.coreID = id;
			
			channelT = emiter.channelT;
			channelC = emiter.channelC;
			
			uid = "@" + emiter.uid;
			signal = new Signal(uid);
		}
		
		public function register(compound:Class):void
		{
			emiter.registerComponent(compound);
		}
		
		public function unregister(compound:Class):void
		{
			emiter.unregisterComponent(compound);
		}
		
		public function sendSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emiter.broadcast(channelT, type, signal);
		}
		
		public function emitSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emiter.broadcast(channelC, type, signal);
		}
		
		public function destroy():void
		{
			signal.dispose();
			signal = null;
			
			channelC = null;
			channelT = null;
			
			emiter.destroy();
			emiter = null;
		}
		
	}

}