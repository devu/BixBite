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
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.interfaces.IModel;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p><i>"According to the standard model billions of years ago some little quantum fluctuation, perhaps a slightly
     * lower density of matter, maybe right where we’re sitting right now, caused our galaxy to start collapsing around here.
     * — Seth Lloyd"</i></p>
     *
     * <p>The <code>Model</code> manages the behavior (business logic) and data of the application to manage the state of the application. 
	 * Same way as you cannot control laws of physics, you shouldn't try to put this responsibility into Controllers. 
	 * You can control many objects that are under defined laws of physics, but it is the Model that defines and manages them.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.4.5
     */
	public class Model extends Actor implements IModel
	{
		private var emiter:Emiter 	= Emiter.getInstance();
		private var slots:Object 	= emiter.slots;
		
		use namespace BIXBITE
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function Model() 
		{
			if (Object(this).constructor == Model) throw new IllegalOperationError("Abstract Class");
		}
		
		/**
		 * Add Slot / register callbacks of specific type of signal and asociate them with Actors.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emiter.addSlot(slots.m, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister this specific actor from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emiter.removeSlot(slots.m, uid, type);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function sendSignal(type:String):void 
		{
			emiter.broadcast(slots.v, type, signal);
		}
		
		/**
		 * 
		 * @param	type
		 * @return
		 */
		public function getSlotReference(type:String):Array
		{
			return emiter.getSlot(slots.v, type);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emiter.removeAllSlotsOf(slots.m, uid);
			super.destroy();
		}
	}

}