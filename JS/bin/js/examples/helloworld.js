HelloWorld.extend(Compound);
function HelloWorld(){
	
	this.init = function(){

		this.register(HelloTransponder);
		this.register(HelloData);
		this.register(Output);
		
		this.addBehaviour("HelloWorld.UPDATE_COPY", CopyHandler);
		this.addBehaviour("HelloWorld.INIT", Initialise);
		
		this.emitSignal("HelloWorld.INIT", { max:1000 } );
	}
	
	HelloTransponder.extend(Transponder);
	function HelloTransponder(){
		
		this.init = function(){
			this.addSensor("mousedown", onMouseDown, this);
		}
		
		var onMouseDown = function(e){
			time = getTimer();
			this.sendSignal("HelloWorld.UPDATE_COPY", { isDefault:false } );
			this.responseToAll("Trace", { trace:"Update copy of 1000 HelloViews "+ (getTimer()-time) } );
		}
	}
	
	HelloData.extend(Data);
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
	
	HelloView.extend(View);
	function HelloView(){
		this.init = function(){
			this.div = document.createElement("div");
			this.div.style.position = "absolute";
			this.div.style.width = "130px";
			this.div.style.height = "20px";
			this.registerContext("label"+this.uid, this.div);
			this.addContext("label"+this.uid, "stage");
			
			this.div.style.left = 200 + Math.random()*500 + "px";
			this.div.style.top = 50 + Math.random()*600 + "px";
			
			this.addSlot("HelloWorld.SET_COPY", onSetCopy);
		}
		var onSetCopy = function (s){
			this.applyCopy(s.params.copy);
		}
	}
	HelloView.prototype.applyCopy = function(copy){
		this.div.innerHTML = copy;
	}
	
	Output.extend(View);
	function Output() {
		
		this.init = function(){
			this.div = document.createElement("div");
			this.registerContext("output1", this.div);
			this.addContext("output1", "stage");
			
			this.addSlot("Trace", onTrace);
		}
		
		var onTrace = function(s){
			this.div.innerHTML = s.params.trace;
		}
	}
	
	Initialise.extend(Behaviour);
	function Initialise(){
		this.init = function(){}
		this.execute = function(s){
			
			var max = s.params.max;
			var time = getTimer();
			
			for (var i = 0; i < max; i++) {
				this.register(HelloView, false);
			};
			
			this.sendSignal("Trace", { trace:"Register Time of "+ max +" HelloView "+ (getTimer()-time) } ); 
			this.emitSignal("HelloWorld.UPDATE_COPY", {isDefault:true});
		}
	}
	
	CopyHandler.extend(Behaviour);
	function CopyHandler(){
		var copy;
		var languages
		var lang = 1;
		
		this.init = function(){
			
			languages = [];
			languages[0] = "english";
			languages[1] = "polish";
			languages[2] = "french";
			languages[3] = "german";
			
			this.addResponder("HelloWorld.COPY_REQUEST", onCopyData, true);
		}

		onCopyData = function(data){
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
	
}











