package test.integration.viewreparenting 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.view.DisplayViewContainer;
	import org.bixbite.framework.view.StageView;
	import test.integration.viewreparenting.view.MyViewA;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class CompoundA extends Compound 
	{
		private var stageView	:StageView;
		private var _myView		:MyViewA;
		
		public function CompoundA() 
		{
			
		}
		
		override public function init():void 
		{
			stageView 	= new StageView();
			
			_myView 	= new MyViewA();
			stageView.addView(_myView);
		}
		
		public function get rootView():DisplayViewContainer 
		{
			return _myView;
		}
		
	}

}