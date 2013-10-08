/**
 * ...
 * @author Daniel Wasilewski
 */

var Display = {
	PORTRAIT:"PORTRAIT",
	LANDSCAPE:"LANDSCAPE",
	DATA_REQUEST:"DisplayManager.DATA_REQUEST",
	RESIZE:"DisplayManager.RESIZE",
	SET_DISPLAY:"DisplaySignal.SET_DISPLAY",
	GET_DISPLAY:"DisplaySignal.GET_DISPLAY",
	ON_ORIENTATION_CHANGED:"DisplaySignal.ON_ORIENTATION_CHANGED",
	ON_RESIZE:"DisplaySignal.ON_RESIZE"
}
 
DisplayManager.extend(Compound);
function DisplayManager(){
	this.init = function(){
		this.register(DisplayData);
		this.register(DisplayTransponder);
		
		this.addBehaviour(Display.SET_DISPLAY, DisplaySet);
		//this.addBehaviour(Display.GET_DISPLAY, DisplayGet);
		this.addBehaviour(Display.RESIZE, DisplayResize);
	}
	
	p = DisplayData.extend(Data);
	function DisplayData(){
		
		this.orientation = Display.PORTRAIT;
		this.root = null;
		
		this.init = function(){
			this.addSlot(Display.DATA_REQUEST, onDataRequest);
			this.addSlot(Display.SET_DISPLAY, onDisplaySet);
		}
		
		var onDataRequest = function (s){
			this.responseTo(s.callerUID, Display.DATA_REQUEST);
		}
		
		var onDisplaySet = function (s){
			this.root 			= s.params.root;
			//this.align 			= s.params.align;
			//this.scaleMode 		= s.params.scaleMode;
			this.frameRate		= s.params.frameRate;
			
			this.responseToAll(Display.DATA_REQUEST);
		}
	}
	p.width = function(){return this.stage.stageWidth}
	p.height = function(){return this.stage.stageHeight}
	
	p = DisplayTransponder.extend(Transponder);
	function DisplayTransponder(){
		this.init = function(){
			this.transmit(Display.GET_DISPLAY);
		}
	}
	
	p = DisplaySet.extend(Behaviour);
	function DisplaySet(){
		
		this.init = function(){}
		
		this.execute = function(s){
			var params = { root:null, align:"TL", scaleMode:"noScale", frameRate:30 };
			
			if (s.params)
				for (var p in s.params) params[p] = s.params[p];
			
			this.sendRequest(Display.SET_DISPLAY, params);
		}
	}
	
	p = DisplayResize.extend(Behaviour);
	function DisplayResize(){
		
		var root, dspData;
		
		this.init = function(){
			this.addResponder(Display.DATA_REQUEST, onData);
		}
		
		var onData = function (data){
			dspData = data;
			root = data.root;
			data.orientation = checkOrientation();
			
			var scp=this;
			window["onresize"] = function(e){
				e.preventDefault ? e.preventDefault() : e.returnValue = false;
				return onDisplayResize.apply(scp, arguments)
			}
		}
		
		var onDisplayResize = function(e){
			this.execute(null);
		}
		
		var checkOrientation = function(){
			return (root.width <= root.height) ? Display.PORTRAIT : Display.LANDSCAPE;
		}
		
		this.execute = function(s){
			
			if (dspData.orientation != checkOrientation()){
				dspData.orientation = currentOrientation;
				emitSignal(Display.ON_ORIENTATION_CHANGED, dspData);
				sendSignal(Display.ON_ORIENTATION_CHANGED, dspData );
			}
			
			this.emitSignal(Display.ON_RESIZE, dspData);
			this.sendSignal(Display.ON_RESIZE, dspData);
		}
	}
}