function HelloDisplayList(){
	
	this.init = function(){
		trace("HelloDisplayList.init");
		this.register(DOMDspManager);
		trace("reg views");
		//this.register(TestTransponder);

		this.register(MainView);
		this.register(SubView);
			
		//this.addBehaviour(CUSTOM_SIGNAL, OnCustomSignal);
	}
}
HelloDisplayList.extend(Compound);

/*
function TestTransponder(){
	this.init = function(){
		this.addSensor(MouseEvent.MOUSE_DOWN, onInputDown);
		this.addSensor(MouseEvent.MOUSE_UP, onInputUp);
	}
}
TestTransponder.extend(Transponder);
*/
function MainView(){
	
	View.call(this);

	this.context = null;
	this.subcontext = null;

	this.init = function(){

		this.addSlot("DisplaySignal.CONTEXT_SET"		, onContextSet);
		this.addSlot("DisplaySignal.CONTEXT_ADDED"		, onContextAdded);
		this.addSlot("DisplaySignal.CONTEXT_REMOVED"	, onContextRemoved);
		
		this.context = document.createElement("div");
		this.sendSignal("DisplaySignal.SET_CONTEXT", { name:"mainView", context:this.context } );
		this.sendSignal("DisplaySignal.ADD_CONTEXT", { name:"mainView", container:"stage" } );
			
		this.subcontext = document.createElement("div");
		this.sendSignal("DisplaySignal.SET_CONTEXT", { name:"mainSubView", context:this.subcontext } );
		this.sendSignal("DisplaySignal.ADD_CONTEXT", { name:"mainSubView", container:"mainView" } );
	}

	var onContextSet = function(s){
		trace("context of", this, "has been set with a name", s.params.name, "and unique id:", s.params.contextUID );
			
		switch(s.params.name){
			case "mainView":
				this.context.setAttribute("style", "position:absolute; left:100px; top:100px;");
				break;
			case "mainSubView":
				this.subcontext.setAttribute("style", "position:absolute; left:10px; top:10px;");
				break;
		}
	}

	var onContextAdded = function(s) {
		trace("context of", this, "has been added to", s.params.container);
			
		switch(s.params.name){
			case "mainView":
				this.context.style.background = "#800000";
				this.context.style.width = "100px";
				this.context.style.height = "100px";
				break;
			case "mainSubView":
				this.subcontext.style.background = "#006600";
				this.subcontext.style.width = "80px";
				this.subcontext.style.height = "80px";
				break;
		}
	}

	var onContextRemoved = function(s){
		trace("context of", this, "has been removed from", s.params.container);
	}
}
MainView.extend(View);

function SubView(){
	
	View.call(this);
	
	this.context = null;

	this.init = function(){

		this.addSlot("DisplaySignal.CONTEXT_SET"		, onContextSet);
		this.addSlot("DisplaySignal.CONTEXT_ADDED"		, onContextAdded);
		this.addSlot("DisplaySignal.CONTEXT_REMOVED"	, onContextRemoved);
		
		this.context = document.createElement("div");
		this.sendSignal("DisplaySignal.SET_CONTEXT", { name:"subView", context:this.context } );
		this.sendSignal("DisplaySignal.ADD_CONTEXT", { name:"subView", container:"mainView" } );
	}

	var onContextSet = function(s){
		trace("context of", this, "has been set with a name", s.params.name, "and unique id:", s.params.contextUID );
		this.context.setAttribute("style", "position:absolute; left:110px; top:20px;");
	}

	var onContextAdded = function(s) {
		this.context.style.background = "#000066";
		this.context.style.width = "60px";
		this.context.style.height = "60px";
	}

	var onContextRemoved = function(s){
		trace("context of", this, "has been removed from", s.params.container);
	}
}
SubView.extend(View);

