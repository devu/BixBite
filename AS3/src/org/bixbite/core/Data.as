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
	import flash.display.Stage;
	
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Data component is a stateless data holder. Data can be directly requested by Behaviours and only.
     * Data components can be nested aka Composite Pattern provides convenient way of sending only needed portions of requested data.</p>
     * <p>In current version of BixBite Data took the role of Signals as Value Objects. Signals are no longer VO.
     * This way BixBite gained lot's of speed by decreasing chain of accessibility for data and avoids signal reattachments.</p>
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
		 * Add Slot / register callbacks of specific type of Signal and asociate with Data component.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emiter.addSlot(slots.d, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister specific Data component from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emiter.removeSlot(slots.d, uid, type);
		}
		
		/**
		 * 
		 * @param	uid
		 * @param	type
		 * @param	params
		 */
		public function responseTo(targetUID:String, type:String, data:IData = null):void
		{
			var vo:IData = (data) ? data : this;
			emiter.dataResponse(slots.c, targetUID, type, vo);
		}
		
		/**
		 * Multicast (one-to-many) method to broadcast signals on Atom communication channel.
		 * @param	type
		 * @param	params
		 */
		public function responseToAll(type:String, data:IData = null):void 
		{
			var vo:IData = (data) ? data : this;
			emiter.dataBroadcast(slots.c, type, vo);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emiter.removeAllSlotsOf(slots.d, uid);
			super.destroy();
		}
	}

}