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
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import org.bixbite.core.interfaces.ITransponder;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Transponder is a abstract class that emits an identifying signal in response to an interrogating received signals.</p>
     * <p>In computer science interrogate means transmit a signal for setting off an appropriate response.
     * Handles mouse and keyboard inputs from the user, mediator between Views and Behaviours.</p>
     * 
	 * @langversion	3.0
     */
	public class Transponder extends Component implements ITransponder 
	{
		use namespace BIXBITE
		
		private var p:Point = new Point(0, 0);
		
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
			emiter.addSlot(slots.t, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister this specific collback from being able to recieve any signals of specific type asociated with this Component.
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emiter.removeSlot(slots.t, uid, type);
		}
		
		/**
		 * Multicast (one-to-many) method to broadcast signals on Compound communication channel.
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:* = null):void 
		{
			if (params) signal.params = params;
			emiter.broadcast(slots.c, type, signal);
		}
		
		/**
		 * Multicast (one-to-many) method to broadcast signals on its own communication channel.
		 * @param	type
		 */
		public function transmit(type:String):void
		{
			emiter.addSlot(slots.t, uid, type, function forward(s:Signal):void
			{
				emiter.broadcast(slots.c, type, s);
			});
		}
		
		/**
		 * Multicast (one-to-many) method to broadcast signals on View communication channel.
		 * @param	type
		 * @param	params
		 */
		public function responseToAll(type:String, params:Object = null):void 
		{
			signal.params = params;
			emiter.broadcast(slots.v, type, signal);
		}
		
		 /**
		 * Signlecast (one-to-one) method to send direct signal on View communication channel.
		  * @param	target any display object of view context
		  * @param	type
		  * @param	...rest
		  */
		public function responseTo(uid:String, type:String, params:Object = null):void 
		{
			signal.params = params;
			emiter.response(slots.v, uid, type, signal);
		}
		
		/**
		 * For performance critical purposes. Using cross-reference slot/signal mechanism will let you send aprox. 30.000.000 signals per second.
		 * Transponders can only reference slots of Atom.
		 * @param	type
		 * @return
		 */
		public function getSlotReference(type:String):Array
		{
			return emiter.getSlot(slots.c, type);
		}
		
		/**
		 * Add platform native listeners in oreder to gather user/system inputs.
		 * @param	type
		 * @param	callback
		 */
		public function addSensor(type:String, callback:Function):void
		{
			stage.addEventListener(type, callback);
		}
		
		/**
		 * Remove platform native listeners.
		 * @param	type
		 * @param	callback
		 */
		public function removeSensor(type:String, callback:Function):void
		{
			stage.removeEventListener(type, callback);
		}
		
		/**
		 * Get all display objects under the mouse point
		 * @return
		 */
		public function getDisplayObjects():Array
		{
			p.x = stage.mouseX;
			p.y = stage.mouseY;
			return stage.getObjectsUnderPoint(p);
		}
		
		/**
		 * Get 1st available display object under mouse point by its name
		 * @param	name
		 * @return
		 */
		public function getDisplayObjectByName(name:String):DisplayObject
		{
			var a:Array;
			for each(var o:DisplayObject in getDisplayObjects()){
				a = o.name.split("@");
				if (a[0] == name) return o;
			}
			
			return null
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