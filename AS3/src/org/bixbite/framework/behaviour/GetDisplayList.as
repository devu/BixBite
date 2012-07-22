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
	import flash.utils.Dictionary;
	import org.bixbite.core.Behaviour;
	import org.bixbite.core.Signal;
	import org.bixbite.framework.data.DisplayListData;
	import org.bixbite.framework.DisplayListManager;
	import org.bixbite.namespaces.DSP_MGR;
	
	/**
	 * @version  compatibility - 0.6.1
	 * @since 0.6.0
	 */
	public class GetDisplayList extends Behaviour 
	{
		use namespace DSP_MGR
		
		internal var list:Dictionary;
		
		public function GetDisplayList() 
		{
			
		}
		
		override public function init():void 
		{
			addResponder(DisplayListManager.GET_DISPLAY_LIST, onDisplayList, true);
		}
		
		private function onDisplayList(s:Signal, data:DisplayListData):void 
		{
			removeResponder(DisplayListManager.GET_DISPLAY_LIST);
			list = data.list;
		}
		
	}

}