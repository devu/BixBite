package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
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
			
			var s:Shape;
			var sc:Sprite;
			var max:int = 1000;
			
			var time:int = getTimer();
			
			for (var i:int = 0; i < max; i++) {
				sc = new Sprite();
				sc.graphics.beginFill(0x444444, 1);
				sc.graphics.drawRect(0,0,50,50);
				sc.x = Math.random()*1900;
				sc.y = Math.random()*800;
				stage.addChild(sc);
				
				s = new Shape();
				s.graphics.beginFill(0xFF0000, 1);
				s.graphics.drawRect(-20,-20,40,40);
				s.x = 25;
				s.y = 25;
				s.rotation = 45;
				sc.addChild(s);
			}

			trace("TIME: " + (getTimer()-time));
			
			/*
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			var textField:TextField = new TextField();
			textField.multiline = false;
			textField.wordWrap = true;
			stage.addChild(textField);
			
			var bmpData:BitmapData = new BitmapData(200, 10);
			var bmp:Bitmap = new Bitmap(bmpData, pixelSnapping);

			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 1);
			shape.graphics.drawRect(0,0,100,100);
			shape.x = 100;
			shape.y = 100;
			shape.rotation = Math.random() * 360;
			stage.addChild(shape);
		
			var sprite:Sprite = new Sprite();
			sprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			sprite.graphics.beginFill(0x00FF00, 1);
			sprite.graphics.drawRect(0,0,50,50);
			sprite.graphics.beginFill(0xFFFF00, 1);
			sprite.graphics.drawRect(1,1,48,48);
			sprite.graphics.beginFill(0x00FFFF, 1);
			sprite.graphics.drawCircle(25,25,20);
			sprite.x = 10;
			sprite.y = 10;
			stage.addChild(sprite);
		
			var time:int = getTimer();
			var s:Sprite;
			for (var i:int = 0; i < 1000; i++) {
				s = new Sprite();
				s.graphics.beginFill(0x0000FF, 1);
				s.graphics.drawRect(0,0,40,40);
				s.x = Math.random()*1200;
				s.y = Math.random()*900;
				sprite.addChild(s);
			};

			trace("TIME: " + (getTimer()-time));
			*/
		}
		
		private function mouseMoveHandler(e:MouseEvent):void{

    	}

		private function mouseDownHandler(e:MouseEvent):void{
    		trace(e.target);
    	}

    	private function mouseUpHandler(e:MouseEvent):void{
    		//trace(stage.getObjectsUnderPoint());
    	}
		
	}

}