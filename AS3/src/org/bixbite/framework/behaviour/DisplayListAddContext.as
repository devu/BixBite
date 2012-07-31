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

package org.bixbite.framework.behaviour 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.DisplayListData;
	import org.bixbite.framework.signal.DisplaySignal;
	
	/**
	 * @version  compatibility - 0.6.2
	 * @since 0.6.0
	 */
	public class DisplayListAddContext extends DisplayListGet
	{
		
		public function DisplayListAddContext() 
		{
			
		}
		
		override public function execute(s:Signal):void 
		{
			var p:Object = s.params;
			var context:DisplayObject 				= list[p.name];
			if (!context) trace("There is no context", p.name, "registered yet");
			
			var container:DisplayObjectContainer 	= list[p.container];
			if (!container) trace("There is no available container", p.container, "registered yet");
			
			var contextViewUID:String = p.viewUID;
			
			container.addChild(context);
			sendSignalTo(contextViewUID, DisplaySignal.CONTEXT_ADDED, { name:p.name, container:p.container } );
		}
		
	}

}