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

package org.bixbite.framework.signal 
{
	/**
	 * @langversion	3.0
	 */
	public class StageSignal
	{
		/**
		 * IN { align:String, scaleMode:String }
		 */
		public static const SET_STAGE				:String = "StageSignal.SET_STAGE";
		
		/**
		 * OUT { orientation:String }
		 */
		public static const ON_ORIENTATION_CHANGED	:String = "StageSignal.ON_ORIENTATION_CHANGED";
		
		/**
		 * OUT { width:Number, height:Number }
		 */
		public static const ON_RESIZE				:String = "StageSignal.ON_RESIZE";
	}

}