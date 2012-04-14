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
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * The Data component is a stateless data holder. Data can be directly requested by Atom, or strictly speaking its Behaviours.
	 * Data components can be nested aka Composite Pattern provides convinent way of sending only needed portions of requested data.
	 * In curent version of BixBite Data took the role of Signals as Value Objects. Signals are no longer VO. 
	 * This way BixBite gained lot's of speed by decreasing chain of accesibility for data and avoids signal reatachments.
	 * Because former Model has been splitted by Atom and Data components, do not use Data component to hold any kind of business logic.
	 * 
	 * @langversion	3.0
	 * @version 0.5.0
     */
	public class Data extends Component implements IData
	{
		use namespace BIXBITE
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function Data() 
		{
			if (Object(this).constructor == Data) throw new IllegalOperationError("Abstract Class");
		}
		
		/**
		 * Add Slot / register callbacks of specific type of Signal and asociate with Data component.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emiter.addSlot(slots.m, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister specific Data component from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emiter.removeSlot(slots.m, uid, type);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emiter.removeAllSlotsOf(slots.m, uid);
			super.destroy();
		}
		
		/**
		 * 
		 */
		public function get system():Stage
		{
			return emiter.BIXBITE::stage;
		}
	}

}