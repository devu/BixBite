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

package org.bixbite.framework.transponder 
{
	
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.framework.signal.KeySignal;
	
	/**
	 * ...
	 * @langversion 3.0
	 */
	public class KeyboardTransponder extends Transponder 
	{
		private var standard		:Dictionary = new Dictionary();
		private var shiftKeys		:Dictionary = new Dictionary();
		private var ctrlKeys		:Dictionary = new Dictionary();
		private var ctrlShiftKeys	:Dictionary = new Dictionary();
		
		//srs
		private var trigger:Function;
		
		override public function init():void 
		{
			addSensor(KeyboardEvent.KEY_DOWN, onKeyDown);
			addSensor(KeyboardEvent.KEY_UP, onKeyUp);
			
			addSlot(KeySignal.SET_MAPPING, onSetMapping);
			
			trigger = getSlots(KeySignal.TRIGGER).getSlotByIndex(0).send;
		}
		
		private function onSetMapping(s:Signal):void 
		{
			switch(s.params.type) {
				case "standard":
					standard = s.params.dictionary;
					break;
				case "shift":
					shiftKeys = s.params.dictionary;
					break;
			}
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			var shiftKey:Boolean = e.shiftKey;
			var ctrlKey:Boolean = e.ctrlKey;
			
			if (ctrlKey && !shiftKey){
				if (e.charCode > 0) checkMapping(e.charCode, ctrlKeys);
			} else if (ctrlKey && shiftKey){
				if (e.charCode > 0) checkMapping(e.charCode, ctrlShiftKeys);
			} else if (!ctrlKey && shiftKey){
				if (e.charCode > 0) checkMapping(e.charCode, shiftKeys);
			} else {
				checkMapping(e.charCode, standard);
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			
		}
		
		private function checkMapping(charCode:uint, dict:Dictionary):void
		{
			fire((dict[charCode]) ? dict[charCode] : dict["default"], charCode);
		}
		
		private function fire(type:String, charCode:uint):void
		{
			signal.params = { type:type, charCode:charCode, char:String.fromCharCode(charCode) };
			trigger(signal);
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
	}
	
}