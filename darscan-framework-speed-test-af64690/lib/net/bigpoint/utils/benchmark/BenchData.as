package net.bigpoint.utils.benchmark {

/**
 * Data holder for benchmarking resoults.
 * @author rbanevicius
 */
public class BenchData {
	public var lastTime:int = 0;

	public var name:String = "";

	public var useCount:int = 0;

	public var totalTime:int = 0;

	public var avarageTime:Number = 0;
	
	/**
	 *
	 */
	public function toString():String {
		var useCountTabs:String = "\t\t\t";

		if (useCount > 999){
			useCountTabs = "\t\t";
		} else if (useCount > 9999999){
			useCountTabs = "\t";
		}
		var totalTimeTabs:String = "\t\t\t";

		if (totalTime > 999){
			totalTimeTabs = "\t\t";
		} else if (totalTime > 9999999){
			totalTimeTabs = "\t";
		}
		return " - " + name + "\t" + useCount + useCountTabs + totalTime + totalTimeTabs + avarageTime;
	}
}
}