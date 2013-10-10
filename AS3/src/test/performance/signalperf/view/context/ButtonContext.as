package test.performance.signalperf.view.context 
{
	import flash.text.TextField;
	import org.bixbite.display.Context;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class ButtonContext extends Context 
	{
		private var label:String;
		
		public function ButtonContext(label:String) 
		{
			this.label = label;
		}
		
		override public function init():void 
		{
			var tf:TextField = new TextField();
			tf.mouseEnabled = false;
			tf.textColor = 0xFFFFFF;
			tf.text = label;
			
			gl.beginFill(0x000000, 1);
			gl.drawRect(0, 0, 100, 20);
			
			body.addChild(tf);
		}
		
	}

}