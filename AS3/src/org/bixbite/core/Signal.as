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
     * All those getters working together provides convenient way to make multiple variations and stay in tact with DRY rule.
     * In this same time helping you solve all architectural problems without referencing objects and keep your Actors completely decoupled, unaware of each other make a perfect modular system to work with and more importantly easy to maintain.</p>
     *
     * <p>In case you need to send more valuable informations within an signal we recommend to create your Custom Signal class, that will extends this base Signal class.
     * You will always stay type safe and have opportunity to ad as many values you want, keeps the basics unchanged and available for a system.
     * You can have multiple Custom Signals to send different values defined for each actor. But by default there is only one Signal attached into Actor. 
	 * Also, you cannot send multiple signals from one Actor at the same time. You need to attach them to Actor before using attachSignal method.</p>
	 * 
	 * @langversion	3.0
	 * @version 0.4.3
     */
	public class Signal implements ISignal 
	{
		private var _phase			:int = 0;
		private var _callerUID		:String;
		private var _action			:String;
		
		/**
		 * Phase
		 */
		public function get phase():int 
		{
			return _phase;
		}
		
		/**
		 * @private
		 */
		BIXBITE function set phase(value:int):void 
		{
			_phase = value;
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
         * Read-only action is an additional and optional parameter, that will let you distinguish different requirements and perform some logical operations within the same type of signal when sending request.
         * This is to avoid boilerplate-code and overloading signal/slot system too much.
         * But can be invoked only by requesters using sendRequest method.
         */
		public function get action():String 
		{
			return _action;
		}
		
		/**
		 * @private
		 * System controlled setter for action optional parameter
		 */
		BIXBITE function set action(value:String):void 
		{
			_action = value;
		}
		
		/**
		 * Public method to deconstruct signal
		 */
		public function dispose():void
		{
			_phase = NaN;
			_callerUID = null;
			_action = null;
			
		}
	}

}