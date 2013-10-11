/**
 * ...
 * @author Daniel Wasilewski
 */

p = CorePerformance.extend(Compound);
function CorePerformance(){
	var results	= [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	var tasks = [];
	var iterator = 0;
	var task = 0;
	var repeat = 10;
	var runner;
	var timeInterval = 200;
	var scope = this;
	
	this.init = function(){
		
		this.register(OutputView);
		this.addBehaviour("traceOutput", TraceOutput);
		
		tasks[0] = "register	Views	10k";
		tasks[1] = "unregister	Views	10k";
		tasks[2] = "register	Views	100k";
		tasks[3] = "unregister	Views	100k";
		tasks[4] = "register	Views	1kk";
		tasks[5] = "unregister	Views	1kk";
		
		tasks[6] = "register	Trans	10k";
		tasks[7] = "unregister	Trans	10k";
		tasks[8] = "register	Trans	100k";
		tasks[9] = "unregister	Trans	100k";
		tasks[10] = "register	Trans	1kk";
		tasks[11] = "unregister	Trans	1kk";
		
		tasks[12] = "register	Data	10k";
		tasks[13] = "unregister	Data	10k";
		tasks[14] = "register	Data	100k";
		tasks[15] = "unregister	Data	100k";
		tasks[16] = "register	Data	1kk";
		tasks[17] = "unregister	Data	1kk";
		
		tasks[18] = "add/remove Behaviour	1k";
		tasks[19] = "add/remove Behaviour	10k";
		tasks[20] = "add/remove Behaviour	100k";
		
		tasks[21] = "add/exe/dispose Behaviour	1k";
		tasks[22] = "add/exe/dispose Behaviour	10k";
		tasks[23] = "add/exe/dispose Behaviour	100k";
		
		tasks[24] = "reg/unreg Views	1k";
		tasks[25] = "reg/unreg Views	10k";
		tasks[26] = "reg/unreg Views	100k";
		
		tasks[27] = "reg/unreg Trans	1k";
		tasks[28] = "reg/unreg Trans	10k";
		tasks[29] = "reg/unreg Trans	100k";
		
		tasks[30] = "reg/unreg Data		1k";
		tasks[31] = "reg/unreg Data		10k";
		tasks[32] = "reg/unreg Data		100k";
		
		tasks[33] = "reg/unreg Views+Ctx+Slot	1k";
		tasks[34] = "reg/unreg Views+Ctx+Slot	10k";
		tasks[35] = "reg/unreg Views+Ctx+Slot	100k";
		
		tasks[36] = "reg/unreg Views+Ctx+Gfx+Slot	1k";
		tasks[37] = "reg/unreg Views+Ctx+Gfx+Slot	10k";
		tasks[38] = "reg/unreg Views+Ctx+Gfx+Slot	100k";
		
		runner = setInterval(run, timeInterval);
	}
	
	run = function() {
		skip=false;
		
		switch(task)
		{
			case 0:
				test1.call(scope, 10000, task);
				break
			case 1:
				test2.call(scope, 10000, task);
				break
			case 2:
				skip = true;
				//test1.call(scope, 100000, task);
				break
			case 3:
				skip = true;
				//test2.call(scope, 100000, task);
				break
			case 4:
				skip = true;
				//test1.call(scope, 1000000, task);
				break
			case 5:
				skip = true;
				//test2.call(scope, 1000000, task);
				break
			case 6:
				test3.call(scope, 10000, task);
				break;
			case 7:
				test4.call(scope, 10000, task);
				break;
			case 8:
				skip = true;
				//test3.call(scope, 100000, task);
				break;
			case 9:
				skip = true;
				//test4.call(scope, 100000, task);
				break;
			case 10:
				skip = true;
				//test3.call(scope, 1000000, task);
				break;
			case 11:
				skip = true;
				//test4.call(scope, 1000000, task);
				break;
			case 12:
				test5.call(scope, 10000, task);
				break;
			case 13:
				test6.call(scope, 10000, task);
				break;
			case 14:
				skip = true;
				//test5.call(scope, 100000, task);
				break;
			case 15:
				skip = true;
				//test6.call(scope, 100000, task);
				break;
			case 16:
				skip = true;
				//test5.call(scope, 1000000, task);
				break;
			case 17:
				skip = true;
				//test6.call(scope, 1000000, task);
				break;
			case 18:
				test7.call(scope, 1000, task);
				break;
			case 19:
				test7.call(scope, 10000, task);
				break;
			case 20:
				skip = true;
				//test7.call(scope, 100000, task);
				break;
			case 21:
				test8.call(scope, 1000, task);
				break;
			case 22:
				test8.call(scope, 10000, task);
				break;
			case 23:
				skip = true;
				//test8.call(scope,1000000, task);
				break;
			case 24:
				test9.call(scope,1000, task);
				break;
			case 25:
				test9.call(scope,10000, task);
				break;
			case 26:
				skip = true;
				//test9.call(scope,100000, task);
				break;
			case 27:
				test10.call(scope,1000, task);
				break;
			case 28:
				test10.call(scope,10000, task);
				break;
			case 29:
				skip = true;
				//test10.call(scope,100000, task);
				break;
			case 30:
				test11.call(scope,1000, task);
				break;
			case 31:
				test11.call(scope,10000, task);
				break;
			case 32:
				skip = true;
				//test11.call(scope,100000, task);
				break;
			case 33:
				test12.call(scope,1000, task);
				break;
			case 34:
				test12.call(scope,10000, task);
				break;
			case 35:
				skip = true;
				//test12.call(scope,100000, task);
				break;
			case 36:
				test13.call(scope,1000, task);
				break;
			case 37:
				test13.call(scope,10000, task);
				break;
			case 38:
				skip = true;
				//test13.call(scope,100000, task);
				break;
			case 39:
				scope.emitSignal("traceOutput", { id:40, row:"COMPLETE" } );
				clearInterval(runner);
				return
				break;
		}
		
		if(skip){
			skipout.call(scope, task);
		} else {
			output.call(scope, task);
		}
		
		if (iterator < repeat){
			iterator++;
		} else {
			clearInterval(runner);
			iterator = 0;
			task++;
		
			timeInterval = parseInt(results[task] / (iterator + 1) + 500);
			runner = setInterval(run, timeInterval);
		}
	}
	
	skipout = function(id){
		iterator=repeat;
		this.emitSignal("traceOutput", { id:id, row:"TASK:" + tasks[id] + "			COUNT:0	TIME:SKIPPED" } );
	}
	
	output = function(id){
		this.emitSignal("traceOutput", { id:id, row:"TASK:" + tasks[id] + "			COUNT:"+ iterator + "	TIME:"+ (results[id] / (iterator + 1)) } );
	}
	
	test1 = function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.register(TestViewA);
		}
		results[resultsId] += (getTimer()-time);
	}
	
	test2 = function (max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.unregister(TestViewA);
		}
		results[resultsId] += (getTimer() - time);
	}
	
	test3 = function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.register(TestTransponder);
		}
		results[resultsId] += (getTimer()-time);
	}
	
	test4 = function (max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.unregister(TestTransponder);
		}
		results[resultsId] += (getTimer() - time);
	}
	
	test5 = function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.register(TestData);
		}
		results[resultsId] += (getTimer()-time);
	}
	
	test6 = function (max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.unregister(TestData);
		}
		results[resultsId] += (getTimer() - time);
	}
	
	test7 = function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.addBehaviour("testSignal", TestBehaviour);
			this.removeBehaviour("testSignal");
		}
		results[resultsId] += (getTimer() - time);
	}
	
	test8 = function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.addBehaviour("testSignal", TestBehaviour, true, true);
		}
		results[resultsId] += (getTimer() - time);
	}
	
	test9 = function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.register(TestViewA);
			this.unregister(TestViewA);
		}
		results[resultsId] += (getTimer() - time);
	}
	
	test10=function(max, resultsId){
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.register(TestTransponder);
			this.unregister(TestTransponder);
		}
		results[resultsId] += (getTimer() - time);
	}
	
	test11=function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.register(TestData);
			this.unregister(TestData);
		}
		results[resultsId] += (getTimer() - time);
	}
	
	test12=function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.register(TestViewB);
			this.unregister(TestViewB);
		}
		results[resultsId] += getTimer() - time;
	}
	
	test13=function(max, resultsId) {
		var time = getTimer();
		for (var i = 0; i < max; i++) {
			this.register(TestViewC);
			this.unregister(TestViewC);
		}
		results[resultsId] += getTimer() - time;
	}
}

TestViewA.extend(View);
function TestViewA(){
	this.init = function(){
		//empty
	}
}

TestViewB.extend(View);
function TestViewB(){
	this.init = function(){
		this.addSlot("testSignalB", onTestSignalB);
		this.getContext("app").addChild(new TestViewBContext());
	}
	
	this.destroy=function(){
		this.getContext("app").removeChildren();
		this.removeSlot("testSignalB");
		View.destroy.call(this);
	}
	
	onTestSignalB=function(s){
		//empty
	}
}

TestViewC.extend(View);
function TestViewC(){
	this.init = function(){
		this.addSlot("testSignalC", onTestSignalC);
		this.getContext("app").addChild(new TestViewCContext());
	}
	
	this.destroy=function(){
		this.getContext("app").removeChildren();
		this.removeSlot("testSignalC");
		View.destroy.call(this);
	}
	
	onTestSignalC=function(s){
		//empty
	}
}

TestViewBContext.extend(Context)
function TestViewBContext(){
	Context.call(this);
	this.init = function(){
		//empty context
	}
}

TestViewCContext.extend(Context)
function TestViewCContext(){
	Context.call(this);
	this.init = function(){
		gl.setMode(GL.DOM);
		gl.beginFill(0x000FFF, 1);
		gl.drawRect(0, 0, 100, 100);
	}
	this.dispose = function(){
		gl.clear();
		Context.dispose.call(this);
	}
}

TestTransponder.extend(Transponder);
function TestTransponder(){
	this.init = function(){
		//empty
	}
}

TestData.extend(Data);
function TestData(){
	this.init = function(){
		//empty
	}
}

TestBehaviour.extend(Behaviour);
function TestBehaviour(){
	this.init = function(){
		//empty
	}
	this.execute = function(){
		//empty
	}
}

TraceOutput.extend(Behaviour);
function TraceOutput(){
	var outputData;
	this.init = function(){
		outputData = []
	}
	this.execute = function(s){
		outputData[s.params.id] = s.params;
		
		var output = "";
		
		outputData.forEach(function(entry) {
			output += entry.row + "<br>";
		});
		
		//for each(var data:Object in outputData) output += data.row + "\n";
		
		this.sendSignal("traceOutput", output);
	}
}

OutputView.extend(View)
function OutputView(){
	var output;
	this.init = function(){
		output = this.registerContext("outputText", new OutputContext());
		output.gl.move(110,0);
		this.getContext("app").addChild(output);
		
		this.addSlot("traceOutput", onTraceOutput);
	}
	
	onTraceOutput = function(s) {
		output.setText(s.params);
	}
}

OutputContext.extend(Context)
function OutputContext(){
	Context.call(this);
	this.init = function(){
		
	}
	this.setText = function(value){
		this.body.innerHTML = value;
	}
}