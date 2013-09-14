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
	import flash.utils.Dictionary;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * @langversion	3.0
	 */
	public class BixBite
	{
		use namespace BIXBITE;
		
		public static const VERSION	:String = "BixBite v0.9.3";
		
		public static var stage		:Stage;
		
		private var cores			:Dictionary = new Dictionary(true);
		
		public var list				:Dictionary = new Dictionary(true);
		
		public function BixBite(stage:Stage) 
		{
			BixBite.stage = stage;
			list["stage"] = stage;
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
		
		public function addContextRoot(id:String, customRoot:*):void 
		{
			list[id] = customRoot;
		}
		
		internal function getContainer(containerId:String):* 
		{
			return list[containerId];
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
		internal function registerCtx(view:View, id:String, context:Class):IContext
		{
			if (list[id]) Error("Context " + id + "is already registered");
			
			var ctx:IContext = new context();
			ctx.parrentView = view;
			ctx.id = id;
			list[id] = ctx;
			list[id].init();
			
			return ctx
		}
		
		/**
		 * Internal display list management method, to unregister a context from the system.
		 * @param	id
		 */
		internal function unregisterCtx(id:String):void
		{
			if (!list[id]) Error("There is no such context: " + id + "registered within display list");
			
			removeCtx(id);
			
			list[id].dispose();
			delete list[id];
		}
		
		/**
		 * Internal display list management method. To add a context to any root container by id.
		 * @param	contextId
		 * @param	containerId
		 */
		internal function addCtx(contextId:String, containerId:String = null):void 
		{
			var context:IContext = list[contextId];
			if (!context) Error("There is no context " + contextId + " registered yet");
			
			var container:* = list[containerId];
			if (!container) Error("Container " + containerId + "cannot be found");
			
			container.addChild(context);
			context.parrentView.onContextAdded();
		}
		
		/**
		 * Internal display list management method. To remove a context by its id.
		 * @param	contextId
		 * @param	containerId
		 */
		internal function removeCtx(contextId:String):void 
		{
			var context:* = list[contextId];
			if (context && context.parent){
				context.parent.removeChild(context);
				context.parrentView.onContextRemoved();
			}
		}
	}

}