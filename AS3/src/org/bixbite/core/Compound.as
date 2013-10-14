/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import org.bixbite.core.interfaces.IComponent;
	import org.bixbite.core.interfaces.ICompound;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Compound represents a container you can build your functional module within. You can register as many Components as you need to achive your goal. 
	 * As well add Behaviours into it to controll a business logic of the module. However it is strongly recomented to keep them as compact and clear as possible. 
	 * If 1 Compound performs multiple unrelated functions, consider refactoring it into set of smaller Compounds registered toogether.</p>
     *
     * <p>In case you have more than one instance of this Compound running on the same Core at the same time, system will use currently running to preserve resources.
     * This is very useful in modular projects. You don't have to worry aboud dependencies or duplicates. 
	 * By registering the same Compound within anothers you act more like what other set of Compounds is required to run your newly created one.</p>
     * 
	 * @langversion	3.0
	 */
	public class Compound extends Component implements ICompound
	{
		use namespace BIXBITE;
		
		/**
		 * list of behaviours (Concider Strongly typed implementation)
		 */
		private var behaviours:Object = { };
		
		/**
		 * Constructor of Compound
		 */
		public function Compound()
		{
			if (Object(this).constructor == Compound) throw new Error("Abstract Class");
		}
		
		/**
		 * Regsiter component within current Compound
		 * @param	component
		 */
		public function register(component:Class, singleton:Boolean = true):IComponent
		{
			return emitter.registerComponent(component, singleton, this);
		}
		
		/**
		 * Unregsiter component within current Compound
		 * @param	component
		 */
		public function unregister(component:Class):void
		{
			emitter.unregisterComponent(component);
		}
		
		/**
		 * Add Behaviour into your Compound to controll business logic of your functional module 
		 * 
		 * @param	type
		 * @param	behaviour
		 * @param	autoDispose, dispose your Behaviour immediately after being executed first time.
		 */
		public function addBehaviour(type:String, behaviour:Class, autoDispose:Boolean = false, autoExecute:Boolean = false):void
		{
			behaviours[type] = new behaviour();
			behaviours[type].initialise(emitter, type, autoDispose, this);
			
			if (autoExecute) behaviours[type].exe(signal);
		}
		
		/**
		 * Remove behaviour from the list of this Compound
		 * @param	type
		 */
		public function removeBehaviour(type:String):void
		{
			if(behaviours[type]){
				behaviours[type].destroy();
				behaviours[type] = null;
				delete behaviours[type]
			}
		}
		
		/**
		 * Multi-cast method to broadcast one singal on entire View channel.
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emitter.broadcast(channelT, type, signal);
		}
		
		/**
		 * Multi-cast method to broadcast one singal on entire Compound channel.
		 * @param	type
		 * @param	params
		 * @param	multicore flag to control communication across multiple cores
		 */
		public function emitSignal(type:String, params:Object = null, multicore:Boolean = false):void
		{
			signal.params = params;
			(!multicore) ? emitter.broadcast(channelC, type, signal) : emitter.broadcastM("C", type, signal);
		}
		
		/**
		 * deconstructor of Compound
		 */
		override public function destroy():void 
		{
			for each(var b:Behaviour in behaviours){
				b.destroy();
				delete behaviours.b;
			}
			behaviours = null;
			
			super.destroy();
		}
	}

}