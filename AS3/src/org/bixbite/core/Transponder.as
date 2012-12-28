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
	import flash.geom.Point;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.interfaces.ITransponder;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Transponder is an component that emits an identifying signal in response to an interrogating received signals.</p>
     * <p>In computer science interrogate means transmit a signal for setting off an appropriate response.
     * It handles mouse and keyboard inputs from the user, mediator between Views and Behaviours.</p>
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
			if (Object(this).constructor == Transponder) throw new Error("Abstract Class");
		}
		
		/**
		 * Add Slot / register callbacks of specific type of signal and asociate them with this Component as well as its communication channel.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emitter.addSlot(channelT, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister this specific collback from being able to recieve any signals of specific type asociated with this Component.
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emitter.removeSlot(channelT, uid, type);
		}
		
		/**
		 * Multi-cast (one-to-many) method to broadcast signals on Compound communication channel.
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:* = null):void 
		{
			signal.params = params;
			emitter.broadcast(channelC, type, signal);
		}
		
		/**
		 * Helper method to transmit recieved signal from View to Compound communication channel directly, when no action is required by Transponder
		 * @param	type
		 */
		public function transmit(type:String):void
		{
			emitter.addSlot(channelT, uid, type, function forward(s:Signal):void
			{
				emitter.broadcast(channelC, type, s);
			});
		}
		
		/**
		 * Multi-cast (one-to-many) method to broadcast signals on View communication channel.
		 * @param	type
		 * @param	params
		 */
		public function responseToAll(type:String, params:Object = null):void 
		{
			signal.params = params;
			emitter.broadcast(channelV, type, signal);
		}
		
		 /**
		 * Signle-cast (one-to-one) method to send direct signal on View communication channel.
		  * @param	target any display object of view context
		  * @param	type
		  * @param	...rest
		  */
		public function responseTo(uid:String, type:String, params:Object = null):void 
		{
			signal.params = params;
			emitter.response(channelV, uid, type, signal);
		}
		
		/**
		 * For performance critical purposes. Using SRS mechanism will let you send signals aprox. 10x faster.
		 * Transponders can only reference slots of Compound Channel (Behaviours)
		 * @param	type
		 * @return 	Slots, list of SLots
		 */
		public function getSlots(type:String):Slots
		{
			return emitter.getSlots(channelC, type);
		}
		
		/**
		 * Add platform native listeners in oreder to gather user/system inputs.
		 * For many platforms this feature may differ, to keep it consistent we call all native communication methods a Sensor.
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
		private function getContextArray(containerId:String):Array
		{
			var container:* = emitter.bixbite.getContainer(containerId);
			if (!container) return null;
			
			p.x = stage.mouseX;
			p.y = stage.mouseY;
			return container.getObjectsUnderPoint(p);
		}
		
		/**
		 * Get 1st available display object under mouse point by its name
		 * @param	name
		 * @return
		 */
		public function getContextById(name:String, containerId:String):IContext
		{
			for each(var ctx:Object in getContextArray(containerId)){
				if (ctx is IContext && ctx.id == name) return IContext(ctx);
			}
			
			return null
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emitter.removeAllSlotsOf(channelC, uid);
			super.destroy();
		}
	}

}