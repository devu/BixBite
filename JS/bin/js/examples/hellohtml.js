HelloHTML.extend(Compound);
function HelloHTML(){
	
	this.init = function(){
		this.register(BallTransponder);
		this.register(Output);
		this.addBehaviour("HelloHTML.POKE", Poke, false, true);
	}
	
	BallTransponder.extend(Transponder);
	function BallTransponder(){
		this.init = function(){
			this.addSensor("click", onMouseClick);
		}
		var onMouseClick = function(e){
			this.sendSignal("HelloHTML.POKE");
		}
	}
	
	Output.extend(View);
	function Output(){
		this.init = function(){
			this.textField = document.createElement("div");
			this.textField.style.top="100px";
			this.textField.style.position="absolute";
			this.registerContext("output"+this.uid, this.textField);
			this.addContext("output"+this.uid, "stage");
			
			this.addSlot("HelloHTML.CREATE_BALL", updateCount);
		}
		var updateCount = function(s){
			this.textField.innerHTML = "Click count:" + s.params;
		}
	}
	
	Ball.extend(View);
	function Ball(){
		var radius=5;
		var xpos;
		var ypos;
		this.init = function(){
			xpos = Math.random()*500 + "px";
			ypos = Math.random()*375 + "px";
			
			var style = "position:absolute; opacity:0.65; background:"+ randomColor() +"; width:"+(radius*2)+"px; height:"+(radius*2)+"px; left:" + xpos + "; top:" + ypos + "; border-radius:"+radius+"px;";
			
			this.circle = document.createElement("div");
			this.circle.setAttribute("style", style);
			
			this.registerContext("circle"+this.uid, this.circle);
			this.addContext("circle"+this.uid, "stage");
			
			this.addSlot("HelloHTML.SHUFFLE", shuffle);
			this.addSlot("HelloHTML.RED_BALL", onMakeBallRed);
		}
		var shuffle = function(){
			radius++;
			var style = "position:absolute; opacity:0.65; background:"+ randomColor() +"; width:"+(radius*2)+"px; height:"+(radius*2)+"px; left:" + xpos  + "; top:" + ypos  + "; border-radius:"+radius+"px;";
			this.circle.setAttribute("style", style);
		}
		var onMakeBallRed = function(){
			radius++;
			var style = "position:absolute; opacity:0.65; background:#882222; width:"+(radius*2)+"px; height:"+(radius*2)+"px; left:" + xpos + "; top:" + ypos + "; border-radius:"+radius+"px;";
			this.circle.setAttribute("style", style);
		}
		var randomColor = function(){
			var color = Math.floor(Math.random() * 16777216).toString(16);
			return '#000000'.slice(0, -color.length) + color;
		}
	}
	
	Poke.extend(Behaviour);
	function Poke(){
		var count = 0;
		this.init = function(){}
		this.execute = function(){
			count++;
			this.sendSignal("HelloHTML.CREATE_BALL", count);
			this.register(Ball, false);
			
			if ((count % 10) == 0){
				this.sendSignal("HelloHTML.RED_BALL");
			} else {
				this.sendSignal("HelloHTML.SHUFFLE");
			}
		}
	}
}