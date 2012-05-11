/**
 * ...
 * @author Daniel Wasilewski
 */

var time = new Date();

function Emiter(){
	
	//private
	var isRunning 	= false;
	var uid 		= -1;
	var slots		= { a: { }, m: { }, v: { }, c: { } };
	
	//protected
	this.addSensor = function(type, callback){
		document.body.addEventListener(type, callback, false);
	}
	
	this.removeSensor = function(type, callback){
		document.body.removeEventListener(type, callback);
	}
	
	this.addSlot = function (channel, callerUID, type, callback){
		if (!channel[type]) channel[type] = { };
		channel[type][callerUID] = callback;
	}
	
	this.removeSlot = function(channel, callerUID, type){
		if (!channel[type]) return;
		delete channel[type][callerUID];
	}
	
	this.broadcast = function(channel, type, signal){
		if (!channel[type]) return;
		for (f in channel[type]) channel[type][f](signal);
	}
	
	this.removeAllSlots = function(channel, type){
		if (!channel[type]) return;
		//for (var uid:String in channel[type]) removeSlot(channel, uid, type);
		delete channel[type];
	}
	
	this.register =  function(referrer) {
		(!isRunning) ? isRunning = true : referrer.module = true;
		return this;
	}
	
	//getters/setters
	this.getInstance = function(){ return this }
	this.getSlots = function(){ return slots; }
	this.uid = function(){ return ++uid }
}

Emiter = new Emiter();

function Compound(){ 	
	
	//private
	var emiter 	= Emiter.register(this);
	var slots 	= emiter.getSlots();
	var uid		= "@" + emiter.uid();
	var signal	= new Signal(uid);
	var module	= false;
	var behaviours = { };
	
	this.stageView = new StageView();
	
	//protected
	this.addBehaviour = function (type, behaviour, autoDispose){
		behaviours.type = behaviour;
		behaviours.type.initialise(emiter, uid, signal, type, slots, autoDispose);
	}
	
	this.removeBehaviour = function(type){
		behaviours.type.dispose();
		delete behaviours.type;
	}
	
	this.startup = function(type){
		emiter.broadcast(slots.a, type, signal);
		emiter.broadcast(slots.v, type, signal);
		emiter.broadcast(slots.c, type, signal);
		
		//emiter.removeAllSlots(slots.a, type);
		//emiter.removeAllSlots(slots.v, type);
		//emiter.removeAllSlots(slots.c, type);
	}
	
	//getters/setters
	this.stage = document.body;
	this.uid = uid;
}

function View(){
	var emiter 	= Emiter.getInstance();
	//this.init = function(){console.log("View.init")}();
	
	this.addSlot = function(type, callback){
		emiter.addSlot(emiter.getSlots().v, emiter.uid(), type, callback);
	}
	
	this.removeSlot = function(type){
		emiter.removeSlot(emiter.getSlots().v, emiter.uid(), type);
	}
	
	this.sendSignal = function(type, params){
		signal.params = params;
		emiter.broadcast(emiter.getSlots().c, type, signal);
	}
}

function Transponder(){
	var emiter 	= Emiter.getInstance();
	//this.init = function(){console.log("Transponder.init")}();
	
	this.sendSignal = function(type, params){
		signal.params = params;
		emiter.broadcast(emiter.getSlots().a, type, signal);
	}
}

function Data(){
	var emiter 	= Emiter.getInstance();
	//this.init = function(){console.log("Data.init")}();
}

function Behaviour(){
	
	this.init = function(){}
	//this.execute = function(s){}
	
	this.initialise = function(emiter, uid, signal, type, slots, autoDispose){
		this.emiter 		= emiter;
		this.uid 			= uid;
		this.signal 		= signal;
		this.type 			= type;
		this.slots 			= slots;
		this.autoDispose 	= autoDispose;
		
		emiter.addSlot(slots.a, uid, type, this.execute);
		
		this.init();
	}
	/*
	this.exe = function(s){
		this.execute(s);
		//if (autoDispose) deconstruct(type);
	}*/
	
	this.sendSignal = function(type, params){
		signal.params = params;
		emiter.broadcast(slots.v, type, signal);
	}
	
	this.dispose = function(){
		emiter.removeSlot(slots.a, uid, type);
		
		signal 	= null;
		emiter 	= null;
		uid 	= null;
		type 	= null;
		slots 	= null;
		dataExec= null;
	}
}

function Signal(uid){
	this.callerUID = uid
}

//framework
DisplayView = function(){
	
}

DisplayViewContainer = function DisplayViewContainer(){
	this.addView = function(view){
		console.log("StageView.addView");
	}
	
	this.removeView = function(view){
		console.log("StageView.removeView");
	}
}

DisplayViewContainer.prototype = new DisplayView();

StageView = function(){
	
}

StageView.prototype = new DisplayViewContainer();

console.log("BixBite v0.5.5 - CORE INIT TIME", new Date()-time);