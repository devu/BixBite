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
	import org.bixbite.debug.Console;
	import org.bixbite.namespaces.BIXBITE;
	
	use namespace BIXBITE;
	
	/**
	 * The Behavior is an anthropomorphic construct that assigns "life" to the activities carried out by Atom in response to stimuli, such as user input (Transponder). 
	 * Also, "a behavior" is a reusable block of code that, when applied to an object, especially a graphical one, causes it to respond to user input in meaningful patterns or to operate independently.
	 * In BixBite Behaviours can broadcast signals only to Views in Multi-cast and Signle-Cast mode. 
	 * Because entire business logic is realised by set of Behaviours they can also request Data components. 
	 * They are part of Atom build in to Compond and the only bridge between application Data and View components.
	 * 
	 * @langversion	3.0
	 * @version 0.6.0
	 */
	public class Behaviour 
	{
		public var signal		:Signal;
		public var remove		:Function;
		
		private var emiter		:Emiter;
		private var uid			:String;
		private var type		:String;
		private var slots		:Object;
		
		private var console		:Console;
		
		public function Behaviour() 
		{
			
		}
		
		BIXBITE function initialise(emiter:Emiter, type:String, slots:Object):void
		{
			this.emiter 		= emiter;
			this.console 		= emiter.console;
			this.uid 			= "@" + emiter.uid;
			this.signal 		= new Signal(uid);
			this.type 			= type;
			this.slots 			= slots;
			
			emiter.addSlot(slots.c, uid, type, exe);
			
			console.initialise(this);
			init();
		}
		
		/**
		 * Internal pre-execute method.
		 * @param	s
		 */
		private function exe(s:Signal):void
		{
			console.execute(this);
			
			execute(s);
			if (remove != null) remove(type);
		}
		
		/**
		 * Abstract method to perform initial preparation before execute() is triggered.
		 */
		public function init():void
		{
			//abstract but not mendatory
		}
		
		/**
		 * Abstract method to hold executable block of code, that performs some business logic.
		 * @param	s signal being sent by coresponding Transponder
		 */
		public function execute(s:Signal):void
		{
			//abstract but not mendatory
		}
		
		/**
		 * Deconstructor of behaviour.
		 */
		public function dispose():void
		{
			emiter.removeSlot(slots.c, uid, type);
			
			signal 	= null;
			emiter 	= null;
			uid 	= null;
			type 	= null;
			slots 	= null;
			remove	= null;
		}
		
		/**
		 * Add responder into Atom in order to request Data. You have opportunity to request data immediately setting autoRequest flag to true.
		 * @param	type
		 * @param	callback
		 * @param	autoRequest request data immediately
		 */
		public function addResponder(type:String, callback:Function, autoRequest:Boolean = false):void
		{
			emiter.addSlot(slots.c, uid, type, callback);
			if (autoRequest) sendRequest(type);
		}
		
		/**
		 * Request data component by type.
		 * @param	type
		 */
		public function sendRequest(type:String, params:Object = null):void
		{
			signal.params = params;
			emiter.broadcast(slots.d, type, signal);
		}
		
		/**
		 * Multi-cast method to broadcast one singal to multiple Atoms and Views components.
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emiter.broadcast(slots.c, type, signal);
			emiter.broadcast(slots.v, type, signal);
		}
		
		/**
		 * Signle-cast method to send signal to speific View component.
		 * @param	uid
		 * @param	type
		 * @param	params
		 */
		public function responseTo(uid:String, type:String, params:Object = null):void
		{
			signal.params = params;
			emiter.response(slots.v, uid, type, signal);
		}
		
		/**
		 * SRS - Slot Reference System
		 * @param	type
		 * @return
		 */
		public function getSlotReference(type:String):Array
		{
			return emiter.getSlot(slots.v, type);
		}
		
	}

}