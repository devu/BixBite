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

package org.bixbite.framework.modules.stats.signal 
{
	import org.bixbite.core.Signal;
	
	/**
	 * @version  compatibility - 0.4.4
	 * @since 0.4.1
	 * 
	 * StatsSignal as value object contains all needed values to update state of StatsView
	 * Set of static constants indicates how we can use it.
	 */
	public class StatsSignal extends Signal 
	{
		public static const START			:String = "statsStart";
		public static const PAUSE			:String = "statsPause";
		public static const DRAW			:String = "statsDraw";
		public static const UPDATE			:String = "statsUpdate";
		public static const TRACE			:String = "statsTrace";
		public static const DISPLAY_TRACE	:String = "statsDisplayTrace";
		
		public var fps			:int = 0;
		public var timer		:int = 0;
		public var ms			:int = 0;
		public var mem			:Number = 0;
		public var max			:Number = 0;
		
		public var infoFPS		:String = "";
		public var infoMEM		:String = "";
		public var infoMAX		:String = "";
		public var infoMS		:String = "";
		public var infoTRACE	:String = "";
		
		/**
		 * When model is deconstructed will ivoke dispose() function automatially. 
		 * This is developer opportunity to make sure his custom signals will clean up all values and feferences.
		 */
		override public function dispose():void 
		{
			super.dispose();
			
			fps		= NaN;
			timer	= NaN;
			ms		= NaN;
			mem		= NaN;
			max		= NaN;
		
			infoFPS		= null;
			infoMEM		= null;
			infoMAX		= null;
			infoMS		= null;
			infoTRACE 	= null;
		}
		
		
	}

}