package test.integration.viewreparenting 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.view.DisplayViewContainer;
	import org.bixbite.framework.view.RootView;
	import test.integration.viewreparenting.view.MyViewA;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class CompoundA extends Compound 
	{
		private var _rootView:RootView;
		
		public function CompoundA() 
		{
			
		}
		
		override public function init():void 
		{
			var myView:MyViewA 	= new MyViewA();
			
			_rootView 	= new RootView();
			_rootView.addView(myView);
		}
		
		public function get rootView():RootView 
		{
			return _rootView;
		}
		
	}

}