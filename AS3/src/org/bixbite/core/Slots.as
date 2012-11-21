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
	import org.bixbite.core.interfaces.IData;
	
	/**
	 * Very basic implementation of one directional linked-list to hold all registered Slot of certain type
	 * @langversion	3.0
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