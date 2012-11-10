function BoxFactory(){
	this.register(BoxFactoryTransponder);
	this.register(MyView);
	
	this.addBehaviour("createBox", CreateBox);
}

BoxFactory.extends(Compound);

function BoxFactoryTransponder(){
	this.transmit("createBox");
}

BoxFactoryTransponder.extends(Transponder);

function MyView(){
	
	var onTest = function(s){
		document.body.style.background = "none repeat scroll 0 0 #012134";
	}

	this.addSlot("test", onTest);
	this.addSlot("show", function(s){trace("MyView.onShow");});
	this.addSlot("hide", function(s){trace("MyView.onHide");});
}

MyView.extends(View);

function CreateBox(){

	var id = 0;

	this.init = function(){
		trace("MyBehaviour.init");
	}

	this.execute = function(s){
		
		var style = "position:absolute; background: "+(s.params.color|| "#882222")+"; width:" + s.params.width + "px; height:" + s.params.height + "px; left:" + s.params.x + "px; top:" + s.params.y + "px";
   		
   		var div = document.createElement("div");
   		div.setAttribute("id", "div"+(++id));
   		div.setAttribute("style", style);
		
	    document.body.appendChild(div);
	}
}


CreateBox.extends(Behaviour);


