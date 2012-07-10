package test.integration.viewreparenting 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.view.DisplayViewContainer;
	import test.integration.viewreparenting.transponder.MyTransponder;
	import test.integration.viewreparenting.view.MyViewB;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class CompoundB extends Compound 
	{
		
		public function CompoundB() 
		{
			
		}
		
		override public function init():void 
		{
			var compoundA	:CompoundA = new CompoundA();
			
			var myView		:MyViewB 	= new MyViewB();
			
			var rootView:DisplayViewContainer = compoundA.rootView;
			rootView.addView(myView);
			rootView.context.x = 300;
			rootView.context.rotation = 40;
		}
		
	}

}