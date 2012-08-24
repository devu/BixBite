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
		trace("MyView.onInit");
		document.body.style.background = "none repeat scroll 0 0 #012134";
	}

	this.addSlot("test", onTest);
	this.addSlot("show", function(s){trace("MyView.onShow");});
	this.addSlot("hide", function(s){trace("MyView.onHide");});
}

MyView.extends(View);

function CreateBox(){

	this.init = function(){
		trace("MyBehaviour.init");
	}

	this.execute = function(s){
		
   		var div = document.createElement('div');
   		div.setAttribute('id', "myDiv");
   
   		div.style.position = "absolute";
   		div.style.background = s.params.color || "#881111";

	    div.style.width = (s.params.width || 100) + "px";
	    div.style.height = (s.params.height || 100) + "px";
	    div.style.left = (s.params.x || 0) + "px";
	    div.style.top = (s.params.y || 0) + "px";
	   
	    if (s.params.html) {
	        div.innerHTML = html;
	    }
	   
	    document.body.appendChild(div);
	}
}


CreateBox.extends(Behaviour);



