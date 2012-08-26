function HelloWorld(){
	
	this.init = function(){

		this.register(HelloTransponder);
		this.register(HelloData);
		this.register(Output);

		this.addBehaviour("HelloWorld.UPDATE_COPY", CopyHandler);
		this.addBehaviour("HelloWorld.INIT", Initialise);

		this.emitSignal("HelloWorld.INIT", {max:1000});
	}
}

HelloWorld.extends(Compound);

function HelloTransponder(){
	
	this.init = function(){
		this.addSensor("mousedown", onMouseDown, this);
	}
	
	var onMouseDown = function(e){
		time = new Date();
		this.sendSignal("HelloWorld.UPDATE_COPY", { isDefault:false } );
		this.responseToAll("Trace", { trace:"Update copy of 1000 HelloViews "+ (new Date()-time) } );
	}
}

HelloTransponder.extends(Transponder);

function HelloData(){
	
	this.english = "<font size='2'> Hello world </font>";
	this.polish = "<font size='2' color='#000000'> Witaj świecie </font>";
	this.french = "<font size='2' color='#000000'> Bonjour tout le monde </font>";
	this.german = "<font size='2' color='#000000'> Hallo Welt </font>";

	this.init = function(){
		this.addSlot("HelloWorld.COPY_REQUEST", onCopyRequest);
	}

	var onCopyRequest = function(s){
		this.responseTo(s.callerUID, "HelloWorld.COPY_REQUEST");
	}
}

HelloData.extends(Data);

function HelloView(){
	
	this.init = function(){
   		
		this.div = document.createElement("div");
	   	this.div.setAttribute("id", "label");
	   	this.div.style.position = "absolute";
	   	this.div.style.left = 200 + Math.random()*1400 + "px";
	   	this.div.style.top = Math.random()*900 + "px";
	   	document.body.appendChild(this.div);

   		this.addSlot("HelloWorld.SET_COPY", onSetCopy);
   }

   	var onSetCopy = function (s){
		this.applyCopy(s.params.copy);
	}
}

HelloView.extends(View);

HelloView.prototype.applyCopy = function(copy){
	this.div.innerHTML = copy;
}

function Output() {
	
	this.init = function(){

		this.div = document.createElement("div");
   		this.div.setAttribute("id", "output");
		document.body.appendChild(this.div);

		this.addSlot("Trace", onTrace);
	}
	
	var onTrace = function(s){
		this.div.innerHTML = s.params.trace;
	}
	
}

Output.extends(View);

function Initialise(){

	this.init = function(){}

	this.execute = function(s){
		
		var max = s.params.max;
		var time = new Date();

		for (var i = 0; i < max; i++) {
			this.register(HelloView, true);
		};

		this.sendSignal("Trace", { trace:"Register Time of "+ max +" HelloView "+ (new Date()-time) } ); 
		this.emitSignal("HelloWorld.UPDATE_COPY", {isDefault:true});
	}
}

Initialise.extends(Behaviour);

function CopyHandler(){
	
	var languages = [];
	var lang = 1;
	var copy = null;

	this.init = function(){
		languages[0] = "english";
		languages[1] = "polish";
		languages[2] = "french";
		languages[3] = "german";

		this.addResponder("HelloWorld.COPY_REQUEST", onCopyData, true);
	}

	var onCopyData = function(data){
		copy = data;
	}

	this.execute = function(s){
   		
   		var isDefault = s.params.isDefault;
			
		if (isDefault){
			this.sendSignal("HelloWorld.SET_COPY", { copy:copy.english } );
			return
		}

		var copyString = "";
			
		switch(languages[lang])
		{
			case "english":
				copyString = copy.english;
				break;
			case "polish":
				copyString = copy.polish;
				break;
			case "french":
				copyString = copy.french;
				break;
			case "german":
				copyString = copy.german;
				break;
		}
		
		this.sendSignal("HelloWorld.SET_COPY", { copy:copyString } );
		
		if (lang < 3){
			lang++;
		} else {
			lang = 0;
		}
	}
}

CopyHandler.extends(Behaviour);