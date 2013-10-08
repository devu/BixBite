/**
Licensed under the Apache License, Version 2.0
@copy (c) See LICENSE.txt
*/

package org.bixbite.core 
{
	import org.bixbite.core.interfaces.IActor;
	
	/**
	 * Very basic implementation of one directional linked-list to hold all registered Slot of certain type
	 * @langversion	3.0
	 */
	public class Slots 
	{
		public var index	:int = -1;
		private var head	:Slot = null;
		private var tail	:Slot = null;
		
		public function addSlot(uid:String, callback:Function):void
		{
			var current:Slot = new Slot(uid, callback);
			current.index = ++index;
			
			(head) ? head.next = current : tail = current;
			head = current;
		}
		
		public function removeSlot(uid:String):void
		{
			var walker:Slot = tail;
			var prev:Slot;
			
			while (walker.next && walker.uid != uid) {
				prev = walker;
				walker = walker.next;
			}
			
			if (prev && walker.next) prev.next = walker.next;
			
			prev = null;
			walker.dispose();
			walker = null;
			index--;
			
			if (index < 0) head = tail = null;
		}
		
		public function broadcast(s:Signal):void
		{
			var walker:Slot = tail;
			
			while(walker.next){
				walker.send(s);
				walker = walker.next;
			}
			
			walker.send(s);
		}
		
		public function broadcastData(d:IActor):void
		{
			var walker:Slot = tail;
			
			while(walker.next){
				walker.send(d);
				walker = walker.next;
			}
			
			walker.send(d);
		}
		
		public function removeAllSlots():void
		{
			var walker:Slot = tail;
			var next:Slot;
			
			while(walker.next){
				next = walker.next;
				walker.dispose();
				walker = null;
				index--;
				walker = next;
			}
			
			tail.dispose();
			tail = head = null;
			index--;
		}
		
		public function getSlotByUID(uid:String):Slot
		{
			var walker:Slot = tail;
			while (walker.next) {
				if (walker.uid == uid) return walker
				walker = walker.next;
			}
			return (walker.uid == uid) ? walker : null;
		}
		
		public function getSlotByIndex(index:uint):Slot
		{
			var walker:Slot = tail;
			while(walker.index != index) walker = walker.next;
			return walker;
		}
		
		public function get numSlots():uint
		{
			return index + 1;
		}
		
	}

}