package org.bixbite.framework.signal 
{
	/**
	 * ...
	 * @author Daniel Wasilewski
	 */
	public class DisplaySignal 
	{
		public static const GET_DISPLAY_LIST	:String		= "DisplaySignal.GET_DSP_LIST"
		public static const ADDED				:String 	= "DisplaySignal.ADDED";
		public static const REMOVED				:String 	= "DisplaySignal.REMOVED";
		
		/**
		 * { name:String, context:DisplayObject }
		 */
		public static const SET_CONTEXT:String 	= "DisplaySignal.SET_CONTEXT";
		
		/**
		 * { name:String, container:String }
		 */
		public static const ADD_CONTEXT:String 	= "DisplaySignal.ADD_CONTEXT";
		
		public static const ADD_VIEW:String 	= "DisplaySignal.ADD_VIEW";
		public static const REMOVE_VIEW:String 	= "DisplaySignal.REMOVE_VIEW";
		
	}

}