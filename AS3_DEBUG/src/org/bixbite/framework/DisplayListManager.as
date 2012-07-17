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

package org.bixbite.framework 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.behaviour.AddDisplayContext;
	import org.bixbite.framework.behaviour.GetDisplayList;
	import org.bixbite.framework.behaviour.SetDisplayContext;
	import org.bixbite.framework.data.DisplayListData;
	import org.bixbite.framework.signal.DisplaySignal;
	import org.bixbite.framework.transponder.DisplayListTransponder;
	import org.bixbite.framework.view.StageView;
	
	/**
	 * @version  compatibility - 0.6.0
	 * @since 0.6.0
	 * 
	 * footprint 8.73kb
	 */
	public class DisplayListManager extends Compound 
	{
		
		public function DisplayListManager() 
		{
			register(DisplayListData);
			register(DisplayListTransponder);
			
			addBehaviour(DisplaySignal.ADD_CONTEXT, AddDisplayContext);
			addBehaviour(DisplaySignal.SET_CONTEXT, SetDisplayContext);
			
			addBehaviour("DisplayListManager.INIT", GetDisplayList);
			sendSignal("DisplayListManager.INIT");
			
			register(StageView);
		}
		
	}

}