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
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>Signal is a base class for all signals being propagated within a system.
     * Provides all necessary getters in read-only mode, and setters automatically controlled by framework.
     * In this same time helping you solve all architectural problems without referencing objects and keep your Components and Compounds completely decoupled, unaware of each other makes a perfect modular system to work with and more importantly easy to maintain.</p>
     *
     * <p>In case you need to send more valuable informations within an signal you can use build in params array.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.5.2
     */
	public class Signal implements ISignal 
	{
		private var _callerUID		:String;
		private var _params			:Array;
		
		public function Signal(uid:String)
		{
			_callerUID = uid;
		}
		
		/**
         * Unique identifier of the caller.
         * This method will provide unique id of the Actor that sending particular signal.
         * This will give you opportunity to respond directly to involved classes without cross-referencing them.
         */
		public function get callerUID():String
		{
			return _callerUID;
		}
		
		/**
		 * @private
		 * System controlled setter for caller unique id.
		 */
		BIXBITE function set callerUID(value:String):void 
		{
			_callerUID = value;
		}
		
		/**
		 * 
		 */
		public function get params():Array 
		{
			return _params;
		}
		
		/**
		 * 
		 */
		public function set params(value:Array):void 
		{
			_params = value;
		}
		
		/**
		 * Public method to deconstruct signal
		 */
		BIXBITE function dispose():void
		{
			_callerUID = null;
			_params = null;
		}
	}

}