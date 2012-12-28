/**The MIT License

@copy (c) 2012 Devu Design Limited, Daniel Wasilewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
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
			
			trace("core " + id);
		}
		
		/**
		 * Internal method to recognise a channel by core id and broadcast a signals on its own emiter
		 * @param	cid		identifier of the core
		 * @param	type	type of signal
		 * @param	signal	passed signal
		 */
		internal function broadcast(cid:String, type:String, signal:Signal):void
		{
			var c:Channel;
			
			switch(cid)
			{
				case "C":
					c = emitter.channelC;
					break;
				case "D":
					c = emitter.channelD;
					break;
				case "T":
					c = emitter.channelT;
					break;
				case "V":
					c = emitter.channelV;
					break;
			}
			
			emitter.broadcast(c, type, signal);
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
		 * Multi-cast method to broadcast one Singal on entire Transponder channel of this Core.
		 * @param	type
		 * @param	params
		 */
		/*
		public function sendSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.broadcast(channelT, type, signal);
		}*/
		
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
			signal.dispose();
			signal = null;
			
			channelC = null;
			//channelT = null;
			
			emitter.destroy();
			emitter = null;
		}
		
	}

}