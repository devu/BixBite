/**
 * ...
 * @author Daniel Wasilewski
 */
var time = new Date();

Function.prototype.extends = function( parrentClass ){ 
	this.prototype = new parrentClass;
	this.prototype.constructor = this;
	this.prototype.parent = parrentClass.prototype;
}

trace = function(params){
	console.log(params);
}

function Emiter(){
	
	//private
	var uid 		= -1;
	var slots		= { a: { }, m: { }, v: { }, c: { } };
	var components	= new Object();
	
	this.registerComponent = function(component){
		if (components[component] != null) {
			components[component].copies++;
			trace(components[component].copies);
			return
		}
		
		components[component] = new component();
	}
	
	this.unregisterComponent = function(component){
		if (!components[component]) return;
		
		if (components[component].copies > 0) {
			components[component].copies--;
			return
		}
		
		components[component].destroy();
		components[component] = null;
		
		delete components[component];
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
		for (f in channel[type]) removeSlot(channel, uid, type);
		delete channel[type];
	}
	
	//getters/setters
	this.getInstance = function(){ return this }
	this.getSlots = function(){ return slots; }
	this.uid = function(){ return ++uid }
}

emiter = new Emiter();

function BixBite(){
	
	var slots = emiter.getSlots();
	
	this.register = function(compound){
		emiter.registerComponent(compound);
	}
	
	this.unregister = function(compound){
		emiter.unregisterComponent(compound);
	}
	
	this.sendSignal = function(type, params){
		signal.params = params;
		emiter.broadcast(slots.t, type, signal);
	}
	
	this.emitSignal = function(type, params){
		signal.params = params;
		emiter.broadcast(slots.c, type, signal);
	}
}

function Component(){
	//private
	var slots 	= emiter.getSlots();
	
	//public
	this.copies = 0;
	this.uid = "@" + emiter.uid();
	this.signal	= new Signal(this.uid);
}

Component.prototype.destroy = function(){
	this.uid = null;
	trace("Component, deconstructor");
}

function Compound(){ 	
	
	//private
	var behaviours = new Object();
	
	this.addBehaviour = function (type, behaviour, autoDispose, autoExecute){
		behaviours.type = behaviour;
		behaviours.type.initialise(emiter, uid, signal, type, slots, autoDispose);
	}
	
	this.removeBehaviour = function(type){
		behaviours.type.dispose();
		delete behaviours.type;
	}
	
	this.destroy = function(){
		trace("this, Compound, deconstructor");
		behaviours = null;
		Component.prototype.destroy.call(this);
	}
}

Compound.extends(Component);

function View(){
	
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

View.extends(Component);

function Transponder(){

	this.addSensor = function(type, callback){
		document.body.addEventListener(type, callback, false);
	}
	
	this.removeSensor = function(type, callback){
		document.body.removeEventListener(type, callback);
	}
	
	this.sendSignal = function(type, params){
		signal.params = params;
		emiter.broadcast(emiter.getSlots().a, type, signal);
	}
}

Transponder.extends(Component);

function Data(){
	
}

Data.extends(Component);

function Behaviour(){
	
	this.init = function(){}

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

console.log("BixBite v0.6.4 - CORE INIT TIME", new Date()-time);