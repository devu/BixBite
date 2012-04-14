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
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import org.bixbite.core.interfaces.ICompound;
	import org.bixbite.core.interfaces.ISignal;
	import org.bixbite.framework.view.StageView;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Compound represents default class you should subclass your Document Class with.</br>
     * This is required to initialise Emiter and signal/slot system.</p>
     *
     * <p>Due to AS3 Document Class restrictions it must subclass DisplayObjectContainer this is why extends Sprite.</br>
     * The only thing we need from it, is to access the system features. And implementation of this class may vary depends of target platforms.
     * This is platform specific implementation when the Stage is the main system IO provider.</p>
     *
     * <p>In case you have more than one Compound running at the same time any following Compound will run as module, using the same reference of Emiter singleton to make shared signal/slot communication possible.
     * This is very useful in modular projects. Consider application, for instance Preloader, that will load external swf build within BixBite framework as well.
     * Preloader may have already some Components initialised you wish to reuse, so you don't have to repeat yourself.</p>
     * 
	 * @langversion	3.0
	 * @version 0.5.0
	 */
	public class Compound extends Sprite implements ICompound
	{
		use namespace BIXBITE
		
		private var emiter		:Emiter 	= Emiter.register(ICompound(this));
		
		private var slots		:Object 	= emiter.slots;
		
		private var _uid		:String		= "@" + emiter.uid;
		
		private var _module		:Boolean 	= false;
		
		private var _stageView	:StageView;
		
		private var signal		:ISignal 	= new Signal(_uid);
		
		public function Compound()
		{
			_stageView = new StageView(emiter.stage);
			if(Object(this).constructor == Compound) throw new IllegalOperationError("Abstract Class");
		}
		
		public function get module():Boolean 
		{
			return _module;
		}
		
		BIXBITE function set module(value:Boolean):void 
		{
			_module = value;
		}
		
		/**
		 * Add Behaviour into your Atom. 
		 * Atom implementation does't exist. It's only contractual and virtual name convention. It has been build into Compound for performance reason.
		 * @param	type
		 * @param	behaviour
		 * @param	autoDispose dispose your Behaviour after being executed.
		 */
		public function addBehaviour(type:String, behaviour:Class, autoDispose:Boolean = false):void
		{
			var b:Behaviour = new behaviour();
			b.initialise(emiter, uid, signal, type, slots, autoDispose);
		}
		
		/**
		 * Unique identifier of this Compound
		 */
		public function get uid():String 
		{
			return _uid;
		}
		
		/**
		 * Build in top view as a base for Composite View Pattern.
		 */
		public function get stageView():StageView 
		{
			return _stageView;
		}
		
		/**
		 * Start Compound with a specific signal type.
		 * @param	type
		 */
		public function startup(type:String):void
		{
			emiter.broadcast(slots.a, type, signal);
			emiter.broadcast(slots.v, type, signal);
			emiter.broadcast(slots.c, type, signal);
			
			emiter.removeAllSlots(slots.a, type);
			emiter.removeAllSlots(slots.v, type);
			emiter.removeAllSlots(slots.c, type);
		}
	}

}