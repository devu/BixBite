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
		private var uid			:String;
		private var channelC	:Channel;
		private var channelT	:Channel;
		
		public var signal		:Signal;
		
		public function Core(id:String) 
		{
			trace("core " + id);
			
			emiter = new Emiter();
			emiter.coreID = id;
			
			channelT = emiter.channelT;
			channelC = emiter.channelC;
			
			uid = "@" + emiter.uid;
			signal = new Signal(uid);
		}
		
		internal function broadcast(cid:String, type:String, signal:Signal):void
		{
			var c:Channel;
			
			switch(cid)
			{
				case "C":
					c = emiter.channelC;
					break;
				case "D":
					c = emiter.channelD;
					break;
				case "T":
					c = emiter.channelT;
					break;
				case "V":
					c = emiter.channelV;
					break;
			}
			
			emiter.broadcast(c, type, signal);
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
		
		public function emitSignal(type:String, params:Object = null, multicore:Boolean = false):void
		{
			signal.params = params;
			if (!multicore) emiter.broadcast(channelC, type, signal);
			else emiter.broadcastM("C", type, signal);
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