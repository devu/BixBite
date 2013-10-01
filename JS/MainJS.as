package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	import org.bixbite.core.BixBite;
	import org.bixbite.core.Core;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class MainJS extends Sprite 
	{
		
		public function MainJS() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			create();
		}
		
		private function create():void
		{
			stage.align = "TL";
			stage.scaleMode = "noScale";
			
			var time:int = getTimer();
		
			var bixbite:BixBite = new BixBite(stage);
			
			var core:Core = bixbite.spawnCore("main");
			core.register(TestCompound);
			
			trace("INIT", (getTimer() - time));
			
			time = getTimer();
			core.emitSignal("ManyToOne", {num:100000});
			trace("Many-to-one", (getTimer()-time));
			
			time = getTimer();
			core.emitSignal("OneToMany");
			trace("One-to-many", (getTimer()-time));
		}
		
	}

}