/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * The Core is a wrapper class to encapsulate Emitter and its registration mechanims and leverage multi-core structure.
	 * It acts as a top level Compound but is not a Component, so it cannot be registered within other Compounds.
	 * It a Class as a direct Product of BixBite factory method spawnCore
	 * @langversion	3.0
     */
	public class Core 
	{
		use namespace BIXBITE;
		
		/**
		 * Reference to Emitter
		 */
		BIXBITE var emitter		:Emitter;
		
		/**
		 * Signal associated with this Core
		 */
		private var signal		:Signal;
		
		/**
		 * Unique identifier of this Core
		 */
		private var uid			:String;
		
		/**
		 * Short refrences to communication channels that this Core can send signals
		 */
		private var channelC	:Channel;
		//private var channelT	:Channel;
		
		/**
		 * Constructor
		 * @param	id, identifier of the core
		 */
		public function Core(id:String) 
		{
			emitter = new Emitter();
			emitter.coreID = id;
			
			//channelT = emitter.channelT;
			channelC = emitter.channelC;
			
			uid = "@" + emitter.uid;
			signal = new Signal(uid);
			
			trace("core " + id, uid);
		}
		
		/**
		 * Internal method to recognise a channel by core id and broadcast a signals on its own emiter
		 * @param	cid		identifier of the core
		 * @param	type	type of signal
		 * @param	signal	passed signal
		 */
		internal function broadcast(cid:String, type:String, signal:Signal):void
		{
			var ch:Channel;
			
			switch(cid)
			{
				case "C":
					ch = emitter.channelC;
					break;
				case "D":
					ch = emitter.channelD;
					break;
				case "T":
					ch = emitter.channelT;
					break;
				case "V":
					ch = emitter.channelV;
					break;
			}
			
			emitter.broadcast(ch, type, signal);
		}
		
		/**
		 * Register Compound within this Core
		 * @param	compound
		 */
		public function register(compound:Class):void
		{
			emitter.registerComponent(compound);
		}
		
		/**
		 * Unregister Compound from this Core
		 * @param	compound
		 */
		public function unregister(compound:Class):void
		{
			emitter.unregisterComponent(compound);
		}
		
		/**
		 * Multi-cast method to broadcast one Singal on entire Compound channel of this Core.
		 * @param	type
		 * @param	params
		 */
		public function emitSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.broadcast(channelC, type, signal);
		}
		
		/**
		 * Deconstructor of the Core
		 */
		public function destroy():void
		{
			signal.destroy();
			signal = null;
			
			channelC = null;
			//channelT = null;
			
			emitter.destroy();
			emitter = null;
		}
		
	}

}