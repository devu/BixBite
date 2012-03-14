package org.bixbite.examples.stats.controller 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.bixbite.core.Controller;
	import org.bixbite.examples.stats.signal.StatsSignal;
	import org.bixbite.examples.stats.signal.TraceSignal;
	
	/**
     * StatsController, will capture event when stats panel has been clicked and perform some basic task.
     * For demonstration purposes, will broadcast TraceSignal to show how sub-view of StatsView is being used.
     *
     * Notice, that in all examples you can't find a single event listener being added to any view.
     * You might argue, controlling stuff like that is a bit over-bloated and complicated. However this is exactly what Controllers are for.
     * Capture user input, work out what to do, perform GUI logic and respond to Model or directly to any View involved.
     *
     * But in those small examples for presentation purposes we have custom implementation each time.
     * In proper application you are more likely to use MouseController or TouchController class that will work out all inputs automatically.
     * There rest of your controllers will only reuse already established signal system. So you don't have to repeat yourself.
     */
	public class StatsController extends Controller 
	{
		private var statsPanel:Sprite;
		
		public function StatsController() 
		{
			
		}
		
		override public function init():void 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			var objects:Array = stage.getObjectsUnderPoint(new Point(stage.mouseX, stage.mouseY));
			
			for each(var o:DisplayObject in objects){
				if (o.name == "statsPanel"){
					statsPanel = o as Sprite;
					statsPanel.startDrag();
					
					//just a test, nothing very useful
					//TODO, subject to concideration, posibility to use sendRequest without callback.
					attachSignal(new TraceSignal("trace something:", this));
					sendRequest(StatsSignal.TRACE, onTraceResponse);
					
					return;
				}
			}
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			statsPanel.stopDrag();
			statsPanel = null;
		}
		
		private function onTraceResponse(s:StatsSignal):void
		{
			trace("fired");
		}
	}

}