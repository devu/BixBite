/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.transponder 
{
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import org.bixbite.core.interfaces.IContext;
	import org.bixbite.core.Signal;
	import org.bixbite.core.Transponder;
	import org.bixbite.signal.KeySignal;

	
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
			var ctx:IContext = getContext("app");
			ctx.addSensor(KeyboardEvent.KEY_DOWN, onKeyDown);
			ctx.addSensor(KeyboardEvent.KEY_UP, onKeyUp);
			
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