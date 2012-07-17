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
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.interfaces.IComponent;
	import org.bixbite.core.interfaces.ICompound;
	import org.bixbite.debug.Console;
	//import org.bixbite.debug.Console;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The Component is a abstract base class for View, Transporder and Data components</p>
	 * 
	 * <p>Purpose of this class is to provide unified way to register the member within Emiter, get unique id and attach default signal into it. 
	 * As well as provide set of commonly shared methods for communication</p>
	 *
	 * @langversion	3.0
	 * @version 0.6.0
	 */
	public class Component implements IComponent
	{
		use namespace BIXBITE;
		
		/**
		 * @private
		 * Every Component will invoke this assigment in order to get short reference to Emiter.
		 */
		BIXBITE var emiter	:Emiter
		
		/**
		 * @private
		 * Based on Emiter short reference, evey Component will get unique id from observer uid iterator.
		 */
		BIXBITE var _uid	:String
		
		/**
		 * @private
		 * Slots reference to provide access to specific channel
		 */
		BIXBITE var slots	:Object
		
		/**
		 * Debuging
		 */
		//BIXBITE var console	:Console;
		
		/**
		 * @private
		 * Default signal attached to this Component
		 */
		public var signal	:Signal
		
		/**
		 * Constructor, Component is an abstract class, cannot be directly instatiated. 
		 */
		public function Component()
		{
			if (Object(this).constructor == Component) throw new IllegalOperationError("Abstract Class");
			
			emiter = Emiter.getInstance();
			slots = emiter.slots;
			_uid = "@" + emiter.uid;
			signal = new Signal(uid);
			
			//DEBUG
			//console = emiter.console;
			//console.setScope(this);
			
			init();
		}
		
		/**
		 * Abstract method init must be overriden in subclasses.
		 */
		public function init():void
		{
			throw new IllegalOperationError("Abstract Method");
		}
		
		/**
		 * Deconstructor of Component. 
		 * Will detach/unregister all registered signals form Emiter and clear all nesesary references.
		 * Subclasses should override this method and call super.destroy().
		 */
		public function destroy():void
		{
			emiter 	= null;
			
			signal.BIXBITE::dispose();
			signal = null;
			
			slots 	= null;
			_uid 	= null;
		}
		
		/**
		 * Unique Component identifier
		 */
		public function get uid():String 
		{
			return _uid;
		}
		
		public function get console():Console
		{
			return emiter.console;
		}
		
	}

}