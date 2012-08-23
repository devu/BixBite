/**
 * ...
 * @author Daniel Wasilewski
 */
var time = new Date();

/**
* SUGAR
*/
Function.prototype.extends = function(parrentClass){ 
	this.prototype = new parrentClass;
	this.prototype.constructor = this;
	this.prototype.parent = parrentClass.prototype;
}

var trace = function(p){
	console.log(p);
}

/**
* EMITER CLASS
*/
function Emiter(){
	
	//private
	var uid 	= -1
	var slots	= { c:{}, d:{}, t:{}, v:{} }
	
	this.r = function(c){
		if (this[c] != null) {
			this[c].copies++;
			return
		}
		
		this[c] = new c();
	}
	
	this.u = function(c){
		if (!this[c]) return;
		
		if (this[c].copies > 0) {
			this[c].copies--;
			return
		}
		
		this[c].destroy();
		this[c] = null;
		
		delete this[c];
	}
		
	this.a = function (ch, uid, t, cb){
		if (!ch[t]) ch[t] = { };
		ch[t][uid] = cb;
	}
	
	this.d = function(ch, uid, t){
		if (!ch[t]) return;
		delete ch[t][uid];
	}
	
	this.b = function(ch, t, s, p){
		if(!ch[t]) return;
		if(p) s.params = p;
		for (f in ch[t]) ch[t][f](s);
	}
	
	this.ra = function(ch, t){
		if (!ch[t]) return;
		for (f in ch[t]) removeSlot(ch, uid, t);
		delete ch[t];
	}
	
	//getters/setters
	this.getSlots = function(){ return slots; }
	this.getUID = function(){ return "@"+ ++uid; }
}

var e = new Emiter();

/**
* BASE COMPONENT CLASS
*/
function Component(){	
	this.slots = e.getSlots();
	this.uid = e.getUID();
	this.signal = new Signal(this.uid);
}

Component.prototype.destroy = function(){
	this.signal.dispose();

	this.uid = null;
	this.slots = null;
	this.signal = null;
}

/**
* CORE DOCUMENT CLASS
*/
function BixBite(){}; 
BixBite.extends(Component);

BixBite.prototype.register = function(c){
	e.r(c);
} 

BixBite.prototype.unregister = function(c){
	e.u(c);
}

BixBite.prototype.sendSignal = function(type, p){
	e.b(this.slots.t, type, this.signal, p);
}

BixBite.prototype.emitSignal = function(type, p){
	e.b(this.slots.c, type, this.signal, p);
}

/**
* COMPOUND CLASS
*/
function Compound(){ 	
	this.behaviours = {};
}
Compound.extends(BixBite);

Compound.prototype.addBehaviour = function (type, behaviour, autoDispose, autoExecute){
	this.behaviours[type] = new behaviour();
	this.behaviours[type].compound = this;
	this.behaviours[type].initialise(this.uid, this.signal, type, autoDispose, autoExecute);

	if (autoExecute) this.behaviours[type].exe(this.signal);
}

Compound.prototype.removeBehaviour = function(type){
	this.behaviours[type].dispose();
	this.behaviours[type] = null;
	delete this.behaviours[type];
}

Compound.prototype.destroy = function(){
	this.behaviours = null;
	Component.prototype.destroy.call(this);
}

/**
* VIEW CLASS
*/
function View(){}; 
View.extends(Component);

View.prototype.addSlot = function(type, callback){
	e.a(this.slots.v, this.uid, type, callback);
}
	
View.prototype.removeSlot = function(type){
	e.d(this.slots.v, this.uid, type);
}
	
View.prototype.sendSignal = function(type, p){
	e.b(this.slots.t, type, signal, p);
}

/**
* TRANSPONDER CLASS
*/
function Transponder(){}; 
Transponder.extends(Component);

Transponder.prototype.addSensor = function(type, callback){
	document.body.addEventListener(type, callback, false);
}
	
Transponder.prototype.removeSensor = function(type, callback){
	document.body.removeEventListener(type, callback);
}
	
Transponder.prototype.addSlot = function(type, callback){
	e.a(this.slots.t, this.uid, type, callback, this);
}
	
Transponder.prototype.removeSlot = function(type){
	e.d(this.slots.t, this.uid, type);
}
	
Transponder.prototype.sendSignal = function(type, p){
	e.b(this.slots.c, type, this.signal, p);
}

Transponder.prototype.transmit = function(type) {
	e.a(this.slots.t, this.uid, type, function(s){
		e.b(e.getSlots().c, type, s);
	});
}

Transponder.prototype.responseToAll = function(type, p){
	e.b(this.slots.v, type, this.signal, p);
}

/**
* DATA CLASS
*/
function Data(){};
Data.extends(Component);

Data.prototype.sendSignal = function(type, p){
	e.b(this.slots.c, type, this.signal, p);
}


/**
* BEHAVIOUR CLASS
*/
function Behaviour(){}

Behaviour.prototype.initialise = function(uid, signal, type, autoDispose, autoExecute){
	this.type 			= type;
	this.uid 			= uid;
		
	this.autoExecute 	= autoExecute;
	this.signal 		= signal;
	signal.autoDispose  = autoDispose;

	e.a(e.getSlots().c, uid, type, this.execute);
		
	this.init();
}

Behaviour.prototype.register = function(component){
	e.r(component);
}

Behaviour.prototype.unregister = function(component){
	e.u(component);
}

Behaviour.prototype.addResponder = function(type, callback, autoRequest){
	e.a(this.slots.c, uid, type, callback);
	if (this.autoRequest) sendRequest(type);
}

Behaviour.prototype.removeResponder = function(type){
	e.ra(this.slots.c, type);
}

Behaviour.prototype.sendRequest = function(type, p){
	e.b(this.slots.d, type, this.signal, p);
}

Behaviour.prototype.sendSignal = function(type, p){
	e.b(this.slots.v, type, this.signal, p);
}

Behaviour.prototype.emitSignal = function(type, p){
	e.b(this.slots.c, type, this.signal, p);
}

Behaviour.prototype.dispose = function(){
	e.r(this.slots.a, this.uid, this.type);
	
	type 				= null;
	this.autoDispose 	= null;
	this.autoExecute 	= null;

	Component.prototype.destroy.call(this);
}

/**
* SIGNAL CLASS
*/
function Signal(uid){
	this.callerUID = uid
}

Signal.prototype.dispose = function(){
	this.callerUID = null;
	this.params = null;
}

trace("BixBite v0.6.4 - CORE INIT TIME: "+ (new Date()-time));