/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Data component is a stateless data holder. Data can be directly requested by Behaviours and only.
     * Data components can be nested aka Composite Pattern provides convenient way of sending only needed portions of requested informations.</p>
     * 
	 * @langversion	3.0
     */
	public class Data extends Component implements IData
	{
		use namespace BIXBITE
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function Data() 
		{
			if (Object(this).constructor == Data) throw new Error("Abstract Class");
		}
		
		/**
		 * Add Slot / register callbacks of specific type of Signal and asociate it with a Data component.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emitter.addSlot(channelD, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister specific Data component from Emitter and prevent from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emitter.removeSlot(channelD, uid, type);
		}
		
		/**
		 * Signle-cast (one-to-one) method to send a Data directly to requestor
		 * @param	uid
		 * @param	type
		 * @param	params
		 */
		public function responseTo(targetUID:String, type:String, data:IData = null):void
		{
			var vo:IData = (data) ? data : this;
			emitter.dataResponse(channelC, targetUID, type, vo);
		}
		
		/**
		 * Multi-cast (one-to-many) method to broadcast Data on Compound communication channel.
		 * @param	type
		 * @param	params
		 */
		public function responseToAll(type:String, data:IData = null):void 
		{
			var vo:IData = (data) ? data : this;
			emitter.dataBroadcast(channelC, type, vo);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emitter.removeAllSlotsOf(channelD, uid);
			super.destroy();
		}
	}

}