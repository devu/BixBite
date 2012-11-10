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
	import org.bixbite.core.interfaces.IComponent;
	import org.bixbite.core.interfaces.IData;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The Component is a abstract base class for all actors of CDTV Compound pattern, Compound, Data, Transporder and View components</p>
	 * 
	 * <p>Purpose of this class is to provide unified way to register the member within Emiter, get unique id and attach default signal into it. 
	 * As well as provide set of commonly shared methods for communication</p>
	 *
	 * @langversion	3.0
	 */
	public class Component implements IComponent
	{
		use namespace BIXBITE;
		
		/**
		 * Number of requests this Component has been registered within a core.
		 * BixBite by default will keep your components as singletons and just need to know how many times is needed to keep it alive before destructor occures.
		 */
		BIXBITE var copies	:int = 0;
		
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
		//BIXBITE var slots	:Object
		
		/**
		 * @private
		 * Default signal attached to this Component
		 */
		public var signal	:Signal
		
		/**
		 * Additional identifier for Components operating as multiple instances of the same Class
		 */
		public var id		:String;
		
		BIXBITE var channelC	:Channel;
		BIXBITE var channelD	:Channel;
		BIXBITE var channelT	:Channel;
		BIXBITE var channelV	:Channel;
		
		/**
		 * Constructor, Component is an abstract class, cannot be directly instatiated. 
		 */
		public function Component()
		{
			if (Object(this).constructor == Component) throw new Error("Abstract Class");
		}
		
		/**
		 * Abstract method init must be overriden in subclasses.
		 */
		public function init():void
		{
			throw new Error("Abstract Method");
		}
		
		/**
		 * Deconstructor of Component. 
		 * Will detach/unregister all registered signals form Emiter and clear all nesesary references.
		 * Subclasses should override this method and call super.destroy().
		 */
		public function destroy():void
		{
			emiter 	= null;
			
			if (this is IData){
				//
			} else {
				signal.dispose();
				signal = null;
			}
			
			//slots 	= null;
			_uid 	= null;
		}
		
		/**
		 * Unique Component identifier
		 */
		public function get uid():String 
		{
			return _uid;
		}
		
		public function get stage():Stage
		{
			return BixBite.stage;
		}
	}

}