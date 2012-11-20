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
	import org.bixbite.core.interfaces.ICompound;
	import org.bixbite.namespaces.BIXBITE;
	
	/**
     * <p>The Compound represents a container you can build your functional module within. You can register as many Components as you need to achive your goal. 
	 * As well add Behaviours into it to controll a business logic of the module. However it is strongly recomented to keep them small and clear. If 1 Compound performs multiple unrelated functions, consider refactoring it into set of smaller Compounds registered toogether.</p>
     *
     * <p>In case you have more than one instance of this Compound running at the same time any following Compound will run as module, using the same reference of Emiter to make shared signal/slot communication possible.
     * This is very useful in modular projects. Consider application, for instance Preloader, that will load external swf build within BixBite framework as well.
     * Preloader may have already some Components initialised you wish to reuse, so you don't have to repeat yourself.</p>
     * 
	 * @langversion	3.0
	 */
	public class Compound extends Component implements ICompound
	{
		use namespace BIXBITE;
		
		private var behaviours:Object = { };
		
		public function Compound()
		{
			if (Object(this).constructor == Compound) throw new Error("Abstract Class");
		}
		
		/**
		 * 
		 * @param	component
		 */
		public function register(component:Class):void
		{
			emiter.registerComponent(component);
		}
		
		/**
		 * 
		 * @param	component
		 */
		public function unregister(component:Class):void
		{
			emiter.unregisterComponent(component);
		}
		
		/**
		 * Add Behaviour into your Compound to controll business logic of your module 
		 * 
		 * @param	type
		 * @param	behaviour
		 * @param	autoDispose, dispose your Behaviour after being executed first time.
		 */
		public function addBehaviour(type:String, behaviour:Class, autoDispose:Boolean = false, autoExecute:Boolean = false):void
		{
			behaviours[type] = new behaviour();
			behaviours[type].initialise(emiter, type, autoDispose, this);
			
			if (autoExecute) behaviours[type].exe(signal);
		}
		
		/**
		 * 
		 * @param	type
		 */
		public function removeBehaviour(type:String):void
		{
			behaviours[type].dispose();
			behaviours[type] = null;
			delete behaviours[type]
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function sendSignal(type:String, params:Object = null):void
		{
			signal.params = params;
			emiter.broadcast(channelT, type, signal);
		}
		
		/**
		 * 
		 * @param	type
		 * @param	params
		 */
		public function emitSignal(type:String, params:Object = null, multicore:Boolean = false):void
		{
			signal.params = params;
			if (!multicore) emiter.broadcast(channelC, type, signal);
			else emiter.broadcastM("C", type, signal);
		}
		
		/**
		 * deconstructor
		 */
		override public function destroy():void 
		{
			for each(var behaviour:Behaviour in behaviours) {
				behaviour.dispose();
			}
			behaviours = null;
			super.destroy();
		}
		
	}

}