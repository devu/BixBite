package test.integration.viewreparenting 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.view.DisplayViewContainer;
	import test.integration.viewreparenting.transponder.ViewTransponder;
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
			var trans		:ViewTransponder 	= new ViewTransponder();
			var compoundA	:CompoundA 			= new CompoundA();
			
			var myViewB		:MyViewB 			= new MyViewB();
			
			var rootView:DisplayViewContainer = compoundA.rootView;
			rootView.addView(myViewB);
		}
		
	}

}