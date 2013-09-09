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
	import flash.utils.Dictionary;
	import org.bixbite.core.interfaces.IComponent;
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Emitter, core of the Signal/Slot notification system of this framework.</p>
     * <p>It is an communication HUB as well as registration point for all coresponding components for each Core. Provides set of methods for Components and keeps it dead simple, fast and straight forward.
	 * If you want to get closer to the native speed of execution, Emitter provides methods to cross-reference slots based on type of the signal called SRS.</p>
     * <p>This implementation of notification system is the fastest, the simplest and lightest to compare to any other solution known in AS3.
     * This is the only solution that will give you robust structure, perfectly decoupled components and opportunity to execute it with almost the seeped of a native local method call within the same Class.
     * You can't go faster than that. So you don't have to sacrifice anything from performance point of view, and you have very powerful modular system that doesn't require any changes if new component/class will be added/moved/removed or refactored</p>
     * <p>Signal/Slot system has been inspired by QT framework, and we took only essence of it.
     * Current version of BixBite is capable of sending around 30.000.000 signals per second using SRS, and 3.000.000 per second using standard API (PC AMD Athlon II 955 Quad Core). Even standard way of sending those signals is the fastest implemenation of the Signal/Slot mechanism ever.</p>
     * 
	 * @langversion	3.0
	 */
	public class Emitter
	{
		use namespace BIXBITE
		
		private var _uid				:int = -1;
		
		public var channelC				:Channel = new Channel();
		public var channelD				:Channel = new Channel();
		public var channelT				:Channel = new Channel();
		public var channelV				:Channel = new Channel();
		public var channelE				:Function;
		public var coreID				:String;
		public var bixbite				:BixBite;
		
		private var components			:Dictionary = new Dictionary(true);
		
		/**
		 * @private
		 * Register component within Emitter
		 * @param	component
		 */
		BIXBITE function registerComponent(component:Class, singleton:Boolean = true):IComponent
		{
			if (singleton && components[component] != null) {
				components[component].copies++;
				return null;
			}
			
			var c:Component = new component();
			c.emitter = this;
			c.channelC = channelC;
			c.channelD = channelD;
			c.channelT = channelT;
			c.channelV = channelV;
			c._uid = "@" + this.uid + "::" + coreID;
			c.signal = new Signal(c.uid);
			
			components[component] = c;
			c.init();
			return c;
		}
		
		/**
		 * @private
		 * Unregister component within Emitter
		 * @param	component
		 */
		BIXBITE function unregisterComponent(component:Class):void 
		{
			if (!components[component]) return;
			
			if (components[component].copies > 0) {
				components[component].copies--;
				return
			}
			
			var uid:String = components[component].uid;
			
			components[component].destroy();
			components[component] = null;
			
			delete components[component];
		}
		
		/**
		 * @private
         * Internal method to add Slot for any Component into this Emitter.
         * This is equivalent of addListener or registerNotification known from different systems and implementations.
         * Can be invoked by any Component, however is encapsulated in subclasses in order to simplify API as well as specify concrete channels of communication.
		 * @param    channel, slot channel
         * @param    callerUID, unique id of the caller
         * @param    type, type of signal
         * @param    callback, listener of the caller that will be added to the slot of certain type and channel
         */
		BIXBITE function addSlot(channel:Channel, callerUID:String, type:String, callback:Function):void
		{
			if (!channel[type]) channel[type] = new Slots();
			Slots(channel[type]).addSlot(callerUID, callback);
		}
		
		/**
		 * @private
		 * Internal method to remove specific Slot and its callback assigned to an Component from Emitter.
		 * Can be invoked by any Component.
		 * @param   channel, slot channel
		 * @param	callerUID, unique id of the caller
		 * @param	type, type of signal
		 */
		BIXBITE function removeSlot(channel:Channel, callerUID:String, type:String):void
		{
			var slots:Slots = channel[type];
			if (!slots || !slots.getSlotByUID(callerUID)) return;
			
			slots.removeSlot(callerUID);
			if (slots.numSlots == 0) delete channel[type];
		}
		
		/**
		 * @private
		 * Remove all registered callbacks by a type of signal on specific channel. 
		 * Can be invoked by any Component.
		 * @param   channel, slot channel
		 * @param	type, type of signal
		 */
		BIXBITE function removeAllSlots(channel:Channel, type:String):void
		{
			if (!channel[type]) return;
			Slots(channel[type]).removeAllSlots();
			delete channel[type];
		}
		
		/**
		 * @private
		 * Remove all registered Slots of concrete Component by his unique id on specific channel.
		 * @param   channel, slot channel
		 * @param	uid, unique id of the caller
		 */
		BIXBITE function removeAllSlotsOf(channel:Channel, uid:String):void
		{
			for (var p:String in channel) removeSlot(channel, uid, p);
		}
		
		/**
		 * @private
		 * Broadcast signal in Multi-cast mode on specific channel and type
		 * @param   channel, slot channel
		 * @param	type
		 * @param	signal
		 */
		BIXBITE function broadcast(channel:Channel, type:String, signal:Signal):void 
		{
			if (!channel[type]) return;
			Slots(channel[type]).broadcast(signal);
		}
		
		/**
		 * @private
		 * Broadcast signal in Multi-cast mode on specific channel and type across multiple cores
		 * @param   cid, slot channel identifier
		 * @param	type
		 * @param	signal
		 */
		BIXBITE function broadcastM(cid:String, type:String, signal:Signal):void 
		{
			channelE(cid, type, signal);
		}
		
		/**
		 * @private
		 * Broadcast data component in Multi-cast mode on specific channel
		 * @param   channel, slot channel
		 * @param	type
		 * @param	data
		 */
		BIXBITE function dataBroadcast(channel:Channel, type:String, data:IData):void 
		{
			if (!channel[type]) return;
			Slots(channel[type]).broadcastData(data);
		}
		
		/**
		 * @private
		 * Send signal response directly to specific Component base on its unique ID
		 * @param   channel, slot channel
		 * @param	callerUID
		 * @param	type
		 * @param	signal
		 */
		BIXBITE function response(channel:Channel, targetUID:String, type:String, signal:Signal):void 
		{
			if (!channel[type]) return;
			Slots(channel[type]).getSlotByUID(targetUID).send(signal);
		}
		
		/**
		 * @private
		 * Send data response directly to specific Component base on its unique ID
		 * @param   channel, slot channel
		 * @param	callerUID
		 * @param	type
		 * @param	data
		 */
		BIXBITE function dataResponse(channel:Channel, targetUID:String, type:String, data:IData):void 
		{
			if (!channel[type]) return;
			Slots(channel[type]).getSlotByUID(targetUID).send(data);
		}
		
		/**
		 * @private
		 * Slot Reference Ssystem (SRS) - get reference to slots by type.
		 * @param	channel
		 * @param	type
		 * @return  Slots list of Slots
		 */
		BIXBITE function getSlots(channel:Channel, type:String):Slots 
		{
			return (channel[type]) ? channel[type] : null;
		}
		
		/**
		 * Deconstructor
		 */
		public function destroy():void
		{
			var slots:Slots;
			for each(slots in channelC) slots.removeAllSlots();
			channelC = null;
			for each(slots in channelD) slots.removeAllSlots();
			channelD = null;
			for each(slots in channelT) slots.removeAllSlots();
			channelT = null;
			for each(slots in channelV) slots.removeAllSlots();
			channelV = null;
			for each(var c:Class in components) unregisterComponent(c);
			components = null;
		}
		
		/**
		 * @private
		 * Privides getter to unique id for all Components.
		 * Each Component will invoke this method on construction time. 
		 * Emitter's uid getter act as a fast system iterator to give each Component unique identifier.
		 */
		BIXBITE function get uid():int 
		{
			return ++_uid;
		}
	}
}