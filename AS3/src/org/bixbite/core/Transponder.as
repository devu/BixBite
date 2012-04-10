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
	import flash.display.DisplayObject;
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.interfaces.ITransponder;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Transponder is a abstract class that emits an identifying signal in response to an interrogating received signals.</p>
	 * In computer sicence interogate means transmit a signal for setting off an appropriate response.
	 * Handles mouse and keyboard inputs from the user, mediator between Views and Atom.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.5.0
     */
	public class Transponder extends Component implements ITransponder 
	{
		use namespace BIXBITE
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function Transponder() 
		{
			if (Object(this).constructor == Transponder) throw new IllegalOperationError("Abstract Class");
		}
		
		/**
		 * Add Slot / register callbacks of specific type of signal and asociate them with this Component as well as its communication channel.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emiter.addSlot(slots.c, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister this specific collback from being able to recieve any signals of specific type asociated with this Component.
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emiter.removeSlot(slots.c, uid, type);
		}
		
		/**
		 * Multicast (one-to-many) method to broadcast signals on Atom communication channel.
		 * TODO - test with multiple compounds if all atoms can recieve same signal from one Transponder.
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:Array = null):void 
		{
			signal.params = params;
			emiter.broadcast(slots.a, type, signal);
		}
		
		/**
		 * For performance critical purposes. Using cross-reference slot/signal mechanism will let you send aprox. 30.000.000 signals per second.
		 * Transponders can only reference slots of Atom.
		 * @param	type
		 * @return
		 */
		public function getSlotReference(type:String):Array
		{
			return emiter.getSlot(slots.a, type);
		}
		
		/**
		 * Add platform native listeners in oreder to gather user/system inputs.
		 * @param	type
		 * @param	callback
		 */
		public function addSensor(type:String, callback:Function):void
		{
			emiter.addSensor(type, callback);
		}
		
		/**
		 * Remove platform native listeners.
		 * @param	type
		 * @param	callback
		 */
		public function removeSensor(type:String, callback:Function):void
		{
			emiter.removeSensor(type, callback);
		}
		
		/**
		 * Find display objects (context of Views) by name under the current input point. 
		 * If object has been found transponder's signal will take over target uid. Otherwise will restore its own.
		 * @param	name
		 * @return
		 */
		public function findObjectByName(name:String):Boolean
		{
			var objects:Array = emiter.getObjects();
			objects.reverse();
			
			for each(var o:DisplayObject in objects){
				var a:Array = o.name.split("@");
				if (a[0] == name){
					signal.BIXBITE::callerUID = "@" + a[1];
					return true;
				}
			}
			
			signal.BIXBITE::callerUID = uid;
			return false;
		}
		
		public function getObjectByName(name:String):DisplayObject
		{
			var objects:Array = emiter.getObjects();
			objects.reverse();
			
			for each(var o:DisplayObject in objects){
				var a:Array = o.name.split("@");
				if (a[0] == name) return o;
			}
			
			return null
		}
		
		public function findObjectByType(object:Class):Boolean
		{
			var objects:Array = emiter.getObjects();
			objects.reverse();
			
			for each(var o:Object in objects){
				if (o is object) return true;
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emiter.removeAllSlotsOf(slots.c, uid);
			super.destroy();
		}
	}

}