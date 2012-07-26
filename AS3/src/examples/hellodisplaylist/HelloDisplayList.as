package examples.hellodisplaylist 
{
	import examples.hellodisplaylist.transponder.TestTransponder;
	import examples.hellodisplaylist.view.MainView;
	import examples.hellodisplaylist.view.SubView;
	import org.bixbite.core.Compound;
	import org.bixbite.framework.DisplayListManager;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class HelloDisplayList extends Compound 
	{
		
		public function HelloDisplayList() 
		{
			
		}
		
		override public function init():void 
		{
			//this is what we are about to use
			register(DisplayListManager);
			
			//internal stuff
			register(TestTransponder);
			
			register(MainView);
			register(SubView);
			
		}
		
	}

}