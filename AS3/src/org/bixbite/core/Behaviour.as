/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import org.bixbite.core.interfaces.IActor;
	import org.bixbite.core.interfaces.IComponent;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * The Behaviour is an anthropomorphic construct that assigns "life" to the activities carried out by Compound in response to stimuli, such as user input (Transponder) or other Behaviours. 
	 * Also, "a behaviour" is a reusable block of code that, when applied to an object, especially a graphical one, causes it to respond to user input in meaningful patterns or to operate independently.
	 * In BixBite Behaviours can broadcast signals to Views in Multi-cast and Signle-Cast mode.
	 * Because entire business logic is realised by set of Behaviours they can also request Data components. 
	 * Built in to Compound are the only bridge between application Data and View components.
	 * 
	 * @langversion	3.0
	 */
	public class Behaviour 
	{
		use namespace BIXBITE;
		
		public var signal		:Signal;
		
		private var emitter		:Emitter;
		private var _uid			:String;
		private var type		:String;
		
		private var autoDispose	:Boolean = false;
		private var compound	:Compound;
		
		BIXBITE var channelC	:Channel;
		BIXBITE var channelD	:Channel;
		BIXBITE var channelT	:Channel;
		BIXBITE var channelV	:Channel;
		
		/**
		 * System controlled Internal method to initialise behaviour
		 * @param	emitter reference to the Emitter
		 * @param	type type of signal associated with this behaviour
		 * @param	autoDispose deconstruct-after-execute flag
		 * @param	compound reference to compound that this behaviour has been registered with
		 */
		BIXBITE function initialise(emitter:Emitter, type:String, autoDispose:Boolean, compound:Compound):void
		{
			this.emitter 		= emitter;
			this._uid 			= "@" + emitter.uid + "::" + emitter.coreID;
			this.signal 		= new Signal(uid);
			this.type 			= type;
			this.channelC 		= emitter.channelC;
			this.channelD 		= emitter.channelD;
			this.channelT 		= emitter.channelT;
			this.channelV 		= emitter.channelV;
			this.autoDispose 	= autoDispose;
			this.compound 		= compound;
			
			emitter.addSlot(channelC, uid, type, exe);
			init();
		}
		
		/**
		 * Internal pre-execute method.
		 * @param	s
		 */
		internal function exe(s:Signal):void
		{
			execute(s);
			if (autoDispose) compound.removeBehaviour(type);
		}
		
		/**
		 * Abstract method to perform initial preparation before execute() is triggered.
		 */
		/*abstract*/ public function init():void { }
		
		/**
		 * Abstract method to hold executable block of code, that performs some business logic.
		 * @param	s signal being sent by coresponding Transponder
		 */
		/*abstract*/ public function execute(s:Signal):void { }
		
		/**
		 * Proxy method for behaviour to register any component within belonging Compound
		 * @param	component
		 * @param	singleton flag for singleton mode
		 */
		public function register(component:Class, singleton:Boolean = true):IComponent
		{
			return emitter.registerComponent(component, singleton);
		}
		
		/**
		 * Proxy method for behaviour to unregister any component from belonging Compound
		 * @param	component
		 */
		public function unregister(component:Class):void
		{
			emitter.unregisterComponent(component);
		}
		
		/**
		 * Add responder into Behaviour in order to recieve requested Data. You have opportunity to request data immediately setting autoRequest flag to true.
		 * @param	type
		 * @param	callback
		 * @param	autoRequest request data immediately
		 */
		public function addResponder(type:String, callback:Function, autoRequest:Boolean = false):void
		{
			emitter.addSlot(channelC, uid, type, callback);
			if (autoRequest) sendRequest(type);
		}
		
		/**
		 * Remove responder by signal type
		 * @param	object
		 */
		public function removeResponder(type:String):void 
		{
			emitter.removeAllSlots(channelC, type);
		}
		
		/**
		 * Request data component by signal type.
		 * @param	type
		 */
		public function sendRequest(type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.broadcast(channelD, type, signal);
		}
		
		/**
		 * Multi-cast method to broadcast one singal on entire Compound channel.
		 * This is also an output of any functional module, means that any other Compound or Behaviour registered within can capture it.
		 * @param	type
		 * @param	params
		 * @param	multicore flag to control communication across multiple cores
		 */
		public function emitSignal(type:String, params:Object = null, multicore:Boolean = false):void
		{
			signal.params = params;
			if (!multicore) emitter.broadcast(channelC, type, signal);
			else emitter.broadcastM("C", type, signal);
		}
		
		/**
		 * Multi-cast method to broadcast one singal on entire View channel.
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.broadcast(channelV, type, signal);
		}
		
		/**
		 * Signle-cast method to send signal to speific View component.
		 * @param	uid
		 * @param	type
		 * @param	params
		 */
		public function sendSignalTo(uid:String, type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.response(channelV, uid, type, signal);
		}
		
		/**
		 * For performance critical purposes. Using SRS mechanism will let you send signals aprox. 10x faster.
		 * Behaviours can only reference slots of View Channel.
		 * @param	type
		 * @return
		 */
		public function getSlots(type:String):Slots
		{
			return emitter.getSlots(channelV, type);
		}
		
		/**
		 * Deconstructor of behaviour.
		 */
		public function dispose():void
		{
			emitter.removeSlot(channelC, uid, type);
			
			signal.dispose();
			signal 		= null 
			
			compound 	= null 
			emitter 	= null 
			_uid 		= null 
			type 		= null 
			
			channelC 	= null
			channelD 	= null
			channelT 	= null
			channelV 	= null
		}
		
		public function get uid():String 
		{
			return _uid;
		}
		
	}

}