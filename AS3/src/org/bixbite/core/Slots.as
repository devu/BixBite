package org.bixbite.core 
{
	import org.bixbite.core.interfaces.IData;
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class Slots 
	{
		public var index	:int = -1;
		private var head	:Slot = null;
		private var tail	:Slot = null;
		
		public function Slots() 
		{
			
		}
		
		public function addSlot(uid:String, callback:Function):void
		{
			var current:Slot = new Slot(uid, callback);
			current.index = ++index;
			
			(head) ? head.next = current : tail = current;
			head = current;
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
		
		public function broadcastData(d:IData):void
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
			var next:Slot;
			
			while(tail.next){
				next = tail.next;
				this[tail.uid] = tail = null;
				index--;
				tail = next;
			}
			
			tail = head = null;
			index--;
		}
		
		public function getSlotByUID(uid:String):Slot
		{
			var walker:Slot = tail;
			while(walker.uid != uid) walker = walker.next;
			return walker;
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