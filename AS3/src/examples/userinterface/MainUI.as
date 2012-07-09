package examples.userinterface 
{
	import org.bixbite.core.Compound;
	import org.bixbite.framework.modules.inputManager.UserInputManager;
	import org.bixbite.framework.view.StageView;
	import org.bixbite.framework.view.ui.Window;
	
	/**
     * @version compatibility 0.5.4
     * @since 0.5.4
     * total footprint //kb
	 */
	public class MainUI extends Compound 
	{
		
		public function MainUI() 
		{
			
		}
		
		override public function init():void 
		{
			var stageView:StageView = new StageView();
			
			var input:UserInputManager = new UserInputManager();
			
			var window:Window = new Window();
			stageView.addView(window);
		}
		
	}

}