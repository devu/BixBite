package org.bixbite.framework.core 
{
	import flash.errors.IllegalOperationError;
	import org.bixbite.framework.interfaces.IController;
	
	/**
	 * ...
	 * @author Daniel Wasilewski
	 * 
	 * <b>Purpose:</b>
	 * Handles user input to change the state of the application
	 * 
	 * <b>Quote:</b>
	 * The primary symptom of a controller is denial, that is I can’t see its symptoms in myself.
	 * —Keith Miller
	 * 
	 * <b>Implementation:</b>
	 * Abstract class implements Actor
	 */
	public class Controller extends Actor implements IController
	{
		public function Controller()
		{
			if (Object(this).constructor == Controller)
				throw new IllegalOperationError("Abstract Class: should be subclassed");
		}
	}

}