/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import org.bixbite.core.interfaces.IComponent;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
	 * <p>The Component is an abstract base class for all actors of CDTV Pattern, Compound, Data, Transporder and View components</p>
	 * 
	 * <p>Purpose of this class is to provide unified way to register the member within Emitter, get unique id and attach default signal into it. 
	 * As well as provide set of commonly shared methods for communication</p>
	 *
	 * @langversion	3.0
	 */
	public class Component implements IComponent
	{
		use namespace BIXBITE;
		
		/**
		 * @private
		 * Number of requests this Component has been registered within a core.
		 * BixBite by default will keep your components as singletons and just need to know how many times is needed to keep it alive before destructor occures.
		 */
		BIXBITE var copies		:int = 0;
		
		/**
		 * @private
		 * Every Component will invoke this assigment in order to get short reference to Emitter.
		 */
		BIXBITE var emitter		:Emitter
		
		/**
		 * @private
		 * Based on Emitter short reference, every Component will get unique id from observer uid iterator.
		 */
		BIXBITE var _uid		:String
		
		/**
		 * @private
		 * Registar of the component
		 */
		BIXBITE var _reg		:Component;
		
		/**
		 * @private
		 * Default signal attached to this Component
		 */
		public var signal		:Signal
		
		/**
		 * Set of CDTV channels asociated with Emitter
		 */
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
		 * It has a function of an Constructor for all subclasses of Component. 
		 * This function will be invoced even before a native constructor.
		 */
		public function init():void
		{
			throw new Error("Abstract Method");
		}
		
		/**
		 * Deconstructor of Component. 
		 * Will detach/unregister all registered signals form Emitter and clear all nesesary references.
		 * Subclasses should override this method and call super.destroy().
		 */
		public function destroy():void
		{
			emitter = null;
			
			signal.destroy();
			signal = null;
			
			_uid 	= null;
			_reg	= null;
			
			channelC = null;
			channelD = null;
			channelT = null;
			channelV = null;
		}
		
		/**
		 * Unique Component identifier
		 */
		public function get uid():String 
		{
			return _uid;
		}
	}

}