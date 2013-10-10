/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import org.bixbite.core.interfaces.IActor;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The View manages the graphical and/or textual output of the application.</p>
	 * <p>Framework provides basic implementation of nested structure of the Views aka Composite Pattern.
	 * Provides set of methods similar to the native Flash Display List and manages nested tree hierarchy.</p>
	 * <p>The View itself is just a subclass of Component to provide base abstract class ready to extend and work with.</p>
	 * 
	 * @langversion	3.0
	 */
	public class View extends Component implements IActor
	{
		use namespace BIXBITE
		
		/**
         * Constructor - this class cannot be directly instantiated.
         */
		public function View() 
		{
			if (Object(this).constructor == View) throw new Error("Abstract Class");
 		}
		
		/**
		 * Add Slot / register callbacks of specific type of signal and asociate them with Actors.
		 * @param	type
		 * @param	callback
		 */
		public function addSlot(type:String, callback:Function):void
		{
			emitter.addSlot(channelV, uid, type, callback);
		}
		
		/**
		 * Remove Slot / unregister this specific actor from being able to recieve any signals of specific type
		 * @param	type
		 */
		public function removeSlot(type:String):void
		{
			emitter.removeSlot(channelV, uid, type);
		}
		
		/**
		 * Multi-cast method to broadcast one singal on entire Transponder channel.
		 * @param	type
		 */
		public function sendSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.broadcast(channelT, type, signal);
		}
		
		/**
		 * Multi-cast method to broadcast one singal on entire View channel.
		 * @param	type
		 * @param	params
		 */
		public function emitSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.broadcast(channelV, type, signal);
		}
		
		/**
		 * Single-cast method to send one singal to an View.
		 * @param	type
		 * @param	params
		 */
		public function emitSignalTo(targetUID:String, type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.response(channelV, targetUID, type, signal);
		}
		
		/**
		 * For performance critical purposes. Using SRS mechanism will let you send signals aprox. 10x faster.
		 * Views can only reference slots of Transponder Channel.
		 * @param	type
		 * @return 	array of slots
		 */
		public function getSlots(type:String):Slots
		{
			return emitter.getSlots(channelT, type);
		}
		
		/**
		 * Regsiter Context within a view
		 * @param	id
		 * @param	context
		 * @return  IContext instance of the created context as interface
		 */
		public function registerContext(id:String, context:IContext):IContext
		{
			return emitter.bixbite.registerCtx(id, context, this);
		}
		
		/**
		 * Unregsiter Context within a view
		 * @param	id
		 */
		public function unregisterContext(id:String):void
		{
			emitter.bixbite.unregisterCtx(id);
		}
		
		/**
		 * Get registered context container
		 * @param	id
		 */
		public function getContext(id:String):IContext
		{
			return emitter.bixbite.getContext(id);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function destroy():void 
		{
			emitter.removeAllSlotsOf(channelV, uid);
			super.destroy();
		}
	}

}