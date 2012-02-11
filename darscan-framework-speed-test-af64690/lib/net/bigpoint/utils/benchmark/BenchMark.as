package net.bigpoint.utils.benchmark {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;
import flash.utils.getTimer;
import flash.utils.setInterval;

/**
 * Class for testing and benchmarking code execution perfarmarce.
 * @author rbanevicius
 */
public class BenchMark {
	static private const MONITOR_WIDTH:int = 500;
	//
	static private var appStage:Stage;
	//
	static private var benchmarks:Dictionary = new Dictionary(); /* of BenchData by string */
	static private var results:Array = [];
	static private var lastId:int = 0;
	
	static public var traceFunction : Function = trace;
	//
	static private var monitorView:Bitmap;
	static private var monitorView_BD:BitmapData;
	//
	static private var isMonitoring:Boolean = false;
	static private var frameRateTime:int;
	static private var frameTime:int;
	static private var lastTimeStamp:int;
	static private var codeTime:int;
	
	/**
	 *
	 */
	static public function start(benchmarkName:String):int {
		lastId++;
		if (benchmarks[benchmarkName] == undefined){
			benchmarks[benchmarkName] = new BenchData();
			benchmarks[benchmarkName].name = benchmarkName;
			var nameTabs:int = Math.ceil(benchmarks[benchmarkName].name.length / 4);
			for (var i:int = nameTabs; i < 8; i++){
				benchmarks[benchmarkName].name += "    ";
			}
			results.push(benchmarks[benchmarkName]);
		}
		if (benchmarks[benchmarkName].lastTime){
			//trace("Benchmark you are trying to start, already started: [" + benchmarkName + "] Maybe you forget to end in before return? Maybe you have recursion?");
		}
		benchmarks[benchmarkName].lastTime = getTimer();
		benchmarks[benchmarkName].useCount++;
		return lastId;
	}
	
	/**
	 *
	 */
	static public function end(benchmarkName:String, benchmarkId:int = 0, printDiff:Boolean = false):void {
		if (benchmarks[benchmarkName]) {
			benchmarks[benchmarkName].totalTime += getTimer() - benchmarks[benchmarkName].lastTime;
			if (printDiff) {
				traceFunction(benchmarkName + " executed in : " + (getTimer() - benchmarks[benchmarkName].lastTime)+" ms");
			}
			benchmarks[benchmarkName].avarageTime = benchmarks[benchmarkName].totalTime / benchmarks[benchmarkName].useCount;
			benchmarks[benchmarkName].lastTime = 0;
		}
	}
	
	static public function init(appStage:Stage, printIntervals:int = 5000):void {
		//trace("BenchMark.init > printIntervals : " + printIntervals);
		if (printIntervals > 0) {
			setInterval(printResults, printIntervals);
		}
		
		appStage.addEventListener(Event.ENTER_FRAME, frameTick);
	}
	
	static public function monitor(appStage:Stage, position:Point = null):void {
		BenchMark.appStage = appStage;
		isMonitoring = true;
		frameRateTime = Math.round(1000 / appStage.frameRate);
		//
		monitorView_BD = new BitmapData(MONITOR_WIDTH, 40, false, 0x000000);
		monitorView = new Bitmap(monitorView_BD);
		if (position) {
			monitorView.x = position.x;
			monitorView.y = position.y;
		}
		appStage.addChild(monitorView);
		//
		appStage.addEventListener(Event.ENTER_FRAME, handleFrameTick);
		appStage.addEventListener(Event.RENDER, handleFrameRender);
		//
		
	}	
	
	
	static private function handleFrameTick(e:Event):void {
		frameTime = getTimer() - lastTimeStamp;
		lastTimeStamp = getTimer();
		//
		appStage.invalidate();
		//
		monitorDraw();
	}
	
	static private function handleFrameRender(e:Event):void {
		codeTime = getTimer() - lastTimeStamp;
	}
	
	static private function monitorDraw():void{
		// drawCodeTime
		monitorView_BD.fillRect(new Rectangle(0, 0, codeTime, 10), 0x00FFFF);
		// draw frameTime
		monitorView_BD.fillRect(new Rectangle(codeTime, 0, frameTime-codeTime, 10), 0xFFFF00);
		// clean rest of the line
		monitorView_BD.fillRect(new Rectangle(frameTime, 0, MONITOR_WIDTH, 10), 0x000000);
		// frame time delimeter
		monitorView_BD.fillRect(new Rectangle(frameRateTime, 0, 1, 10), 0xFF0000);
		//
		// copy one line down
		monitorView_BD.copyPixels(monitorView_BD, new Rectangle(0, 9, MONITOR_WIDTH, 40), new Point(0, 10));
		// separator for main graph and log.
		monitorView_BD.fillRect(new Rectangle(0, 9, MONITOR_WIDTH, 1), 0xD8D8D8);
	}
	
	static private function frameTick(e:Event):void {
		end("frameTick");
		start("frameTick");
	}
	
	static private function printResults():void {
		//results.sortOn("useCount", Array.DESCENDING);
		results.sortOn("avarageTime", Array.DESCENDING);
		//Debug.inspect(results);
		traceFunction("######################## BENCHMARK ##########################");
		traceFunction("   NAME\t\t\t\t\t\t\t\tUSES\t\tALL_T\t\tAVR_T\t");
		for (var i:int = 0; i < results.length; i++){
			traceFunction(results[i].toString());
		}
		traceFunction("#############################################################");
	}
}
}