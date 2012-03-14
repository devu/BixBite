package org.bixbite.examples.stats.signal 
{
	import org.bixbite.core.Signal;
	
	/**
	 * StatsSignal as value object contains all needed values to update state of StatsView
	 * Set of static constants indicates how we can use it.
	 */
	public class StatsSignal extends Signal 
	{
		public static const START			:String = "statsStart";
		public static const PAUSE			:String = "statsPause";
		public static const DRAW			:String = "statsDraw";
		public static const UPDATE			:String = "statsUpdate";
		public static const TRACE			:String = "statsTrace";
		public static const DISPLAY_TRACE	:String = "statsDisplayTrace";
		
		public var fps			:int = 0;
		public var timer		:int = 0;
		public var ms			:int = 0;
		public var mem			:Number = 0;
		public var max			:Number = 0;
		
		public var infoFPS		:String = "";
		public var infoMEM		:String = "";
		public var infoMAX		:String = "";
		public var infoMS		:String = "";
		public var infoTRACE	:String = "";
		
		/**
		 * When model is deconstructed will ivoke dispose() function automatially. 
		 * This is developer opportunity to make sure his custom signals will clean up all values and feferences.
		 */
		override public function dispose():void 
		{
			super.dispose();
			
			fps		= NaN;
			timer	= NaN;
			ms		= NaN;
			mem		= NaN;
			max		= NaN;
		
			infoFPS		= null;
			infoMEM		= null;
			infoMAX		= null;
			infoMS		= null;
			infoTRACE 	= null;
		}
		
		
	}

}