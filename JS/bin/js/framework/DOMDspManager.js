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
	}
}
DOMDspManager.extend(Compound);

/*
DATA
*/
function DOMDspManagerData(){
	
	Data.call(this);

	this.list = {};

	this.init = function(){
		trace("DOMDspManagerData.init");
		this.list["stage"] = document.body;
		this.addSlot("DspManager.INIT", onInitDsp);
	}

	var onInitDsp = function(s){
		this.responseToAll("DspManager.INITIALISED");
	}
}
DOMDspManagerData.extend(Data);

/*
TRANSPONDER
*/
function DOMDspManagerTrans(){
	
	Transponder.call(this);

	this.init = function(){
		trace("DOMDspManagerTrans.init");
		this.addSlot("DspManager.SET_CONTEXT", onSetContext);
		this.addSlot("DspManager.ADD_CONTEXT", onAddContext);
		this.addSlot("DspManager.REMOVE_CONTEXT", onRemoveContext);
	}

	var onSetContext = function(s){
		trace(this+"::onSetContext");
		s.params.viewUID = s.callerUID;
		this.sendSignal("DspManager.SET_CONTEXT", s.params);
	}

	var onAddContext = function(s){
		trace(this+"::onAddContext");
		s.params.viewUID = s.callerUID;
		this.sendSignal("DspManager.ADD_CONTEXT", s.params);
	}

	var onRemoveContext = function(s){
		
	}
}
DOMDspManagerTrans.extend(Transponder);

function DOMDspInitialise(){
	
	Behaviour.call(this);

	this.init = function(){}
	this.execute = function(){
		this.sendRequest("DspManager.INIT");
	}
}
DOMDspInitialise.extend(Behaviour);

function DOMDspInit(){
	
	Behaviour.call(this);

	this.list = null;
	trace("DOMDspInit:CONSTRUCTED");

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
DOMDspInit.extend(Behaviour);

function DOMDspSetContext(){
	//this.init = function(){};
	DOMDspInit.call(this);

	this.execute = function(s){
		trace("DOMDspSetContext::execute");
		var name = s.params.name;
		var context	= s.params.context;
		var ctxuid = name +s.params.viewUID;
		context.setAttribute("uid", ctxuid);

		this.list[name] = context;
		this.sendSignalTo(s.params.viewUID, "DspManager.CONTEXT_SET", { name:name, contextUID:ctxuid } );
	}
}
DOMDspSetContext.extend(DOMDspInit);

function DOMDspAddContext(){
	//this.init = function(){};
	DOMDspInit.call(this);

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

		var vUID = "@"+context.getAttribute("uid").split("@")[1];
		this.sendSignalTo(vUID, "DspManager.CONTEXT_ADDED", { name:ctxName, container:ctnName } );
	}
}
DOMDspAddContext.extend(DOMDspInit);

function DOMDspRemoveContext(){
	//this.init = function(){};
	DOMDspInit.call(this);

	this.execute = function(s){
		trace("DOMDspRemoveContext.execute");
	}
}
DOMDspRemoveContext.extend(DOMDspInit);