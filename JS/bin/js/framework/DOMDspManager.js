function DOMDspManager(){
	
	this.init = function(){

		trace("DOMDspManager.init");

		this.register(DOMDspManagerData);
		this.register(DOMDspManagerTrans);

		this.addBehaviour("DspManager.INIT"				, DOMDspInitialise);
		this.addBehaviour("DspManager.SET_CONTEXT"		, DOMDspSetContext);
		this.addBehaviour("DspManager.ADD_CONTEXT"		, DOMDspAddContext);
		this.addBehaviour("DspManager.REMOVE_CONTEXT"	, DOMDspRemoveContext);

		this.emitSignal("DspManager.INIT");

		this.register(TestView);
		this.register(SubView);
	}
}
DOMDspManager.extends(Compound);

/*
DATA
*/
function DOMDspManagerData(){
	
	this.list = {};

	this.init = function(){
		trace("DOMDspManagerData.init");

		this.list["stage"] = document.body;
		this.addSlot("DspManager.INIT", onInitDsp);
	}

	var onInitDsp = function(s){
		trace("DOMDspManagerData::onInitDsp");
		this.responseToAll("DspManager.INITIALISED");
	}
}
DOMDspManagerData.extends(Data);

/*
TRANSPONDER
*/
function DOMDspManagerTrans(){
	
	this.init = function(){
		this.addSlot("DspManager.SET_CONTEXT", onSetContext);
		this.addSlot("DspManager.ADD_CONTEXT", onAddContext);
		this.addSlot("DspManager.REMOVE_CONTEXT", onRemoveContext);
	}

	var onSetContext = function(s){
		s.params.viewUID = s.callerUID;
		this.sendSignal("DspManager.SET_CONTEXT", s.params);
	}

	var onAddContext = function(s){
		s.params.viewUID = s.callerUID;
		this.sendSignal("DspManager.ADD_CONTEXT", s.params);
	}

	var onRemoveContext = function(s){
		
	}
}
DOMDspManagerTrans.extends(Transponder);

function DOMDspInitialise(){
	
	this.init = function(){}
	this.execute = function(){
		this.sendRequest("DspManager.INIT");
	}
}
DOMDspInitialise.extends(Behaviour);

function DOMDspInit(){
	
	this.list = null;

	this.init = function(){
		this.addResponder("DspManager.INITIALISED", onDspInit);
	}

	var onDspInit = function(data){
		this.removeResponder("DspManager.INITIALISED");
		this.list = data.list;
	}

	this.execute = function(s){
		trace("DOMDspGet.execute");
		this.sendRequest("DspManager.INIT");
	}
}
DOMDspInit.extends(Behaviour);

function DOMDspSetContext(){
	this.execute = function(s){
		
		var name = s.params.name;
		var context	= s.params.context;
		var ctxuid = name +s.params.viewUID;
		context.setAttribute("id", ctxuid);

		this.list[name] = context;
		this.sendSignalTo(s.params.viewUID, "DspManager.CONTEXT_SET", { name:name, contextUID:ctxuid } );
	}
}
DOMDspSetContext.extends(DOMDspInit);

function DOMDspAddContext(){
	this.execute = function(s){
		
		var ctxName = s.params.name;
		var ctnName = s.params.container;

		var context = this.list[ctxName];

		if (!context) 
			trace("There is no context " + ctxName + " registered yet");

		var container = this.list[ctnName];
		if (!container) 
			trace("There is no container " + ctnName + " registered yet");

		container.appendChild(context);

		var vUID = "@"+context.getAttribute("id").split("@")[1];
		this.sendSignalTo(vUID, "DspManager.CONTEXT_ADDED", { name:ctxName, container:ctnName } );
	}
}
DOMDspAddContext.extends(DOMDspInit);

function DOMDspRemoveContext(){
	this.execute = function(s){
		trace("DOMDspRemoveContext.execute");
	}
}
DOMDspRemoveContext.extends(DOMDspInit);

/*
TEST VIEWS
*/
function TestView(){
	this.init = function(){

		this.addSlot("DspManager.CONTEXT_SET", onContextSet);

		this.context = document.createElement("div");
		this.sendSignal("DspManager.SET_CONTEXT", { name:"sprite", context:this.context });
		this.sendSignal("DspManager.ADD_CONTEXT", { name:"sprite", container:"stage" });
	}

	var onContextSet = function(){
		var style = "position:absolute; background:#800000; width:100px; height:100px; left:100px; top:100px;";
		this.context.setAttribute("style", style);
	}
}
TestView.extends(View);

function SubView(){
	this.init = function(){
		
		this.addSlot("DspManager.CONTEXT_SET", onContextSet);

		this.context = document.createElement("div");
		this.sendSignal("DspManager.SET_CONTEXT", { name:"shape", context:this.context });
		this.sendSignal("DspManager.ADD_CONTEXT", { name:"shape", container:"sprite" });
	}

	var onContextSet = function(){
		var style = "position:absolute; background:#808000; width:10px; height:10px; left:10px; top:10px;";
		this.context.setAttribute("style", style);
	}
}
SubView.extends(View);