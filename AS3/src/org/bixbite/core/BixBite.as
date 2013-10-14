/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import flash.system.System;
	import flash.utils.Dictionary;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.display.IDisplayList;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * @langversion	3.0
	 */
	public class BixBite
	{
		use namespace BIXBITE;
		
		public static const VERSION	:String = "0.9.5";
		
		private var cores	:Dictionary = new Dictionary(true);
		private var root	:IDisplayList;
		public var list		:Dictionary = new Dictionary(true);
		
		public function BixBite(root:IDisplayList) 
		{
			trace(VERSION);
			this.root = root;
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
				cores[id] = null;
				delete cores[id];
			}
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
		 * Add display context
		 * @param	id
		 */
		public function addContext(id:String, context:IContext):void 
		{
			root.addChild(registerCtx(id, context));
		}
		
		/**
		 * Get any registered display container
		 * @param	id
		 * @return
		 */
		public function getContext(id:String):IContext
		{
			return list[id];
		}
		
		/**
		 * Internal display list management method, to register a context within the system.
		 * @param	view
		 * @param	id
		 * @param	context
		 * @return	IContext
		 */
		internal function registerCtx(id:String, ctx:IContext, view:View = null):IContext
		{
			if (list[id]) Error("Context " + id + "is already registered");
			list[id] = ctx;
			ctx.view = view;
			ctx.init();
			ctx.id = id;
			
			return ctx;
		}
		
		/**
		 * Internal display list management method, to unregister a context from the system.
		 * @param	id
		 */
		internal function unregisterCtx(id:String):void
		{
			if (!list[id]) Error("There is no such context: " + id + "registered within display list");
			
			var context:* = list[id];
			if (context && context.parent){
				context.parent.removeChild(context);
			}
			
			list[id].destroy();
			delete list[id];
		}
	}

}