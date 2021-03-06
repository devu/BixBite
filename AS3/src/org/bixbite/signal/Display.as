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

package org.bixbite.signal 
{
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class Display
	{
		public static const PORTRAIT				:String = "PORTRAIT";
		public static const LANDSCAPE				:String = "LANDSCAPE";
		
		static public const DATA_REQUEST			:String = "DisplayManager.DATA_REQUEST";
		static public const RESIZE					:String = "DisplayManager.RESIZE";
		
		/**
		 * IN { align:String, scaleMode:String }
		 */
		static public const SET_DISPLAY				:String = "DisplaySignal.SET_DISPLAY";
		static public const GET_DISPLAY				:String = "DisplaySignal.GET_DISPLAY";
		/**
		 * OUT stageData
		 */
		static public const ON_ORIENTATION_CHANGED	:String = "DisplaySignal.ON_ORIENTATION_CHANGED";
		static public const ON_RESIZE				:String = "DisplaySignal.ON_RESIZE";
		
	}

}