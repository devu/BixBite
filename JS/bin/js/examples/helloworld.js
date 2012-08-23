function HelloWorld(){
	
	this.register(HelloTransponder);
	this.register(HelloData);
	this.register(HelloView);

	this.addBehaviour("HelloWorld.UPDATE_COPY", CopyHandler);

	this.sendSignal("HelloWorld.INIT", {max:20});
}

HelloWorld.extends(Compound);

function HelloTransponder(){
	
	//private
	var onInit = function (s, self){
		self.responseToAll("HelloWorld.INIT", s.params );
	}

	onInit.self = this;
	
	this.addSlot("HelloWorld.INIT", onInit);
}

HelloTransponder.extends(Transponder);

function HelloData(){
	trace("HelloData.init");
}

HelloData.extends(Data);

function HelloView(){
	
	trace("HelloView.onInit");
}

HelloView.extends(View);

function CopyHandler(){
	
	trace("CopyHandler.onInit");

	//protected
	this.init = function(){
		trace("MyBehaviour.init");
	}

	this.execute = function(s){
   		trace("execute");
	}
}

CopyHandler.extends(Behaviour);