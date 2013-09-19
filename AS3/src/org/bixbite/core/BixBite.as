/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * @langversion	3.0
	 */
	public class BixBite
	{
		use namespace BIXBITE;
		
		public static const VERSION	:String = "BixBite v0.9.4";
		
		public static var stage		:Stage;
		
		private var cores			:Dictionary = new Dictionary(true);
		
		public var list				:Dictionary = new Dictionary(true);
		
		public function BixBite(stage:Stage) 
		{
			BixBite.stage = stage;
			addContainer("root", new ContextContainer());
			
			trace(VERSION);
		}
		
		/**
		 * Factory method to create a Core
		 * @param	id
		 * @return newly created Core class
		 */
		public function spawnCore(id:String):Core 
		{
			var c:Core = new Core(id);
			c.emitter.channelE = incomingSignal;
			c.emitter.bixbite = this;
			return cores[id] = c;
		}
		
		/**
		 * Core deconstructor
		 * @param	id
		 */
		public function destroyCore(id:String):void 
		{
			if(cores[id]){
				cores[id].destroy();
				delete cores[id];
			}
		}
		
		/**
		 * Add display container
		 * @param	id
		 */
		public function addContainer(id:String, container:*):void 
		{
			container.id = id;
			stage.addChild(container);
			list[id] = container;
			container.init();
		}
		
		/**
		 * Get any registered display container
		 * @param	id
		 * @return
		 */
		public function getContainer(id:String):ContextContainer 
		{
			return list[id];
		}
		
		/**
		 * Channel for multi-core communication
		 * @param	cid		core identifier
		 * @param	type	transmited type of signal
		 * @param	signal	transmited signal
		 */
		private function incomingSignal(cid:String, type:String, signal:Signal):void 
		{
			for each(var c:Core in cores) c.broadcast(cid, type, signal);
		}
		
		/**
		 * Internal display list management method, to register a context within the system.
		 * @param	view
		 * @param	id
		 * @param	context
		 * @return	IContext
		 */
		internal function registerCtx(view:View, id:String, context:Class):Context
		{
			if (list[id]) Error("Context " + id + "is already registered");
			
			var ctx:IContext = new context();
			ctx.parrentView = view;
			ctx.id = id;
			list[id] = ctx;
			ctx.init();
			
			return Context(ctx)
		}
		
		/**
		 * Internal display list management method, to unregister a context from the system.
		 * @param	id
		 */
		internal function unregisterCtx(id:String):void
		{
			if (!list[id]) Error("There is no such context: " + id + "registered within display list");
			
			//removeCtx(id);
			var context:* = list[id];
			if (context && context.parent){
				context.parent.removeChild(context);
				context.parrentView.onContextRemoved();
			}
			
			list[id].dispose();
			delete list[id];
		}
	}

}