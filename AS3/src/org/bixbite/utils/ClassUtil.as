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

package org.bixbite.utils 
{
	import flash.display.DisplayObject;
	import flash.utils.describeType;
	
	/**
	 * @langversion	3.0
     */
	public class ClassUtil 
	{
		
		public function ClassUtil()
		{
			
		}
		
		/**
		 * @param	object, Class to check
		 * @param	value, Extended Class to search
		 * @return
		 */
		public static function extendsClass(object:Class, search:String):Boolean 
		{
			var xmllist:XMLList = describeType(object).factory;
			var type:String;
			for each(var value:String in xmllist.extendsClass.@type) {
				type = value.split("::")[1];
				if (type == search) return true;
			}
			
			return false;
		}
		
		public static function retrieveUID(context:Object):String
		{
			return (context.name) ? "@" + context.name.split("@")[1] : null;
		}
		
		public static function retrieveName(context:Object):String
		{
			return (context.name) ? context.name.split("@")[0] : null;
		}
		
	}

}