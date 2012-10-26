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
	import org.bixbite.core.interfaces.IView;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The View manages the graphical and/or textual output of the application.</p>
	 * <p>Framework provides basic implementation of nested structure of the Views aka Composite Pattern.
	 * Provides set of methods similar to the native Flash Display List and manages nested tree hierarchy.</p>
	 * <p>The View itself is just a subclass of Component to provide base abstract class ready to extend and work with.</p>
	 * 
	 * @langversion	3.0
	 */
	public class View extends Component implements IView
	{
		use namespace BIXBITE
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function View() 
		{
			if (Object(this).constructor == View) throw new IllegalOperationError("Abstract Class");
 		}
		
		/**
		 * Add Slot / register callbacks of specific type of signal and asociate them with Actors.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emiter.addSlot(slots.v, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister this specific actor from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emiter.removeSlot(slots.v, uid, type);
		}
		
		/**
		 * Multi-cast method to broadcast one singal on entire Transponder channel.
		 * @param	type
		 */
		public function sendSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emiter.broadcast(slots.t, type, signal);
		}
		
		/**
		 * Multi-cast method to broadcast one singal on entire View channel.
		 * @param	type
		 * @param	params
		 */
		public function emitSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emiter.broadcast(slots.v, type, signal);
		}
		
		/**
		 * SRS
		 * @param	type
		 * @return 	array of slots
		 */
		public function getSlotReference(type:String):Array
		{
			return emiter.getSlot(slots.t, type);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emiter.removeAllSlotsOf(slots.v, uid);
			super.destroy();
		}
	}

}