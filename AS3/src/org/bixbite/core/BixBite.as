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
	import flash.utils.Dictionary;
	
	/**
	 * @langversion	3.0
	 */
	public class BixBite
	{
		public static const VERSION	:String = "BixBite v0.8.0";
		public static var stage		:Stage;
		
		private var cores			:Dictionary = new Dictionary(true);
		
		public function BixBite(stage:Stage) 
		{
			BixBite.stage = stage;
			
			trace(VERSION);
		}
		
		public function spawnCore(id:String):Core 
		{
			return cores[id] = new Core(id);
		}
		
		public function destroyCore(id:String):void 
		{
			if(cores[id]){
				cores[id].destroy();
				delete cores[id];
			}
		}
	}

}