function BoxFactory(){
	this.register(BoxFactoryTransponder);
	this.register(MyView);
	this.addSlot
	this.addBehaviour("createBox", CreateBox);
}

BoxFactory.extends(Compound);

function BoxFactoryTransponder(){
	this.transmit("createBox");
}

BoxFactoryTransponder.extends(Transponder);

function MyView(){
	
	var onTest = function(s){
		trace("MyView.onInit");
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
		
		/*
		style += "transform:rotate(7deg);";
		style += "-ms-transform:rotate(7deg);"
		style += "-moz-transform:rotate(7deg);"
		style += "-webkit-transform:rotate(7deg);"
		style += "-o-transform:rotate(7deg);"
		*/
   		
   		var div = document.createElement("div");
   		div.setAttribute("id", "div"+(++id));
   		div.setAttribute("style", style);

   		/*
		div.style.position = "absolute";
   		div.style.background = s.params.color || "#881111";
	    div.style.width = (s.params.width || 100) + "px";
	    div.style.height = (s.params.height || 100) + "px";
	    div.style.left = (s.params.x || 0) + "px";
	    div.style.top = (s.params.y || 0) + "px";
	   	*/
	    document.body.appendChild(div);
	}
}


CreateBox.extends(Behaviour);



