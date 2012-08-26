function HelloHTML(){
	
	this.init = function(){

		this.register(BallTransponder);
		this.register(Output);

		this.addBehaviour("HelloFlash.POKE", Poke, false, true);
	}
}

HelloHTML.extends(Compound);

function BallTransponder(){

	this.init = function(){
		this.addSensor("click", onMouseClick);
	}

	var onMouseClick = function(e){
		this.sendSignal("HelloFlash.POKE");
	}
}

BallTransponder.extends(Transponder);

function Output(){

	this.init = function(){
		trace("Output.init");

		this.textField = document.createElement("div");
   		this.textField.setAttribute("id", "output");
		document.body.appendChild(this.textField);

		this.addSlot("HelloFlash.CREATE_BALL", updateCount);
	}

	var updateCount = function(s){
		this.textField.innerHTML = "Click count:" + s.params;
	}

}

Output.extends(View);

function Ball(){

	var radius = 5;
	var xpos = 0
	var ypos =0;

	this.init = function(){

		xpos = Math.random()*800 + "px";
		ypos = Math.random()*800 + "px";

		var style = "position:absolute; background:"+ randomColor() +"; width:"+(radius*2)+"px; height:"+(radius*2)+"px; left:" + xpos + "; top:" + ypos + "; border-radius:"+radius+"px;";
   		
   		this.circle = document.createElement("div");
   		this.circle.setAttribute("id", "circle");
   		this.circle.setAttribute("style", style);
		
	    document.body.appendChild(this.circle);

	    this.addSlot("HelloFlash.SHUFFLE", shuffle);
		this.addSlot("HelloFlash.RED_BALL", onMakeBallRed);
	}

	var shuffle = function(){
		radius++;
		var style = "position:absolute; background:"+ randomColor() +"; width:"+(radius*2)+"px; height:"+(radius*2)+"px; left:" + xpos + "; top:" + ypos + "; border-radius:"+radius+"px;";
		this.circle.setAttribute("style", style);
	}

	var onMakeBallRed = function(){
		radius++;
		var style = "position:absolute; background:#882222; width:"+(radius*2)+"px; height:"+(radius*2)+"px; left:" + xpos + "; top:" + ypos + "; border-radius:"+radius+"px;";
		this.circle.setAttribute("style", style);
	}

	var randomColor = function(){
		var color = Math.floor(Math.random() * 16777216).toString(16);
		return '#000000'.slice(0, -color.length) + color;
	}

}

Ball.extends(View);

function Poke(){
	
	var count = 0;

	this.init = function(){}

	this.execute = function(){
		count++;

		this.sendSignal("HelloFlash.CREATE_BALL", count);
		this.register(Ball, true);

		if ((count % 10) == 0){
			this.sendSignal("HelloFlash.RED_BALL");
		} else {
			this.sendSignal("HelloFlash.SHUFFLE");
		}
	}
}

Poke.extends(Behaviour);