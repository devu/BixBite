/**
 * ...
 * @author Daniel Wasilewski
 */
var time = new Date();

/**
* SUGAR
*/
Function.prototype.extends = function(Class){ 
	this.prototype = new Class;
	this.prototype.constructor = this;
	this.prototype.parent = Class.prototype;
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
	this.slt	= { c:{}, d:{}, t:{}, v:{} }

	//register component
	this.reg = function(c){
		if (this[c] != null) {
			this[c].copies++;
			return
		}
		
		this[c] = new c();
	}

	//unregister component
	this.unr = function(c){
		if (!this[c]) return;
		
		if (this[c].copies > 0) {
			this[c].copies--;
			return
		}
		
		this[c].destroy();
		this[c] = null;
		
		delete this[c];
	}

	//add sot
	this.as = function (ch, uid, t, cb){
		if (!ch[t]) ch[t] = { };
		ch[t][uid] = cb;
	}

	//remove slot
	this.rs = function(ch, uid, t){
		if (!ch[t]) return;
		delete ch[t][uid];
	}

	//broadcast
	this.brc = function(ch, t, s, p){
		if(!ch[t]) return;
		if(p) s.params = p;
		for (var f in ch[t]) ch[t][f](s);
	}

	//remove all slt
	this.ras = function(ch, t){
		if (!ch[t]) return;
		for (var f in ch[t]) removeSlot(ch, uid, t);
		delete ch[t];
	}
	
	//getters/setters
	this.uid = function(){ return "@"+ ++uid; }
}

var emi = new Emiter();

/**
* BASE COMPONENT CLASS
*/
function Cmp(){
	this.slt = emi.slt;
	this.uid = emi.uid();
	this.signal = new Signal(this.uid);
}

Cmp.prototype.destroy = function(){
	this.signal.dispose();

	this.uid = null;
	this.slt = null;
	this.signal = null;
}

/**
* CORE DOCUMENT CLASS
*/
function BixBite(){}; 
BixBite.extends(Cmp);

BixBite.prototype.register = function(c){
	emi.reg(c);
} 

BixBite.prototype.unregister = function(c){
	emi.unr(c);
}

BixBite.prototype.sendSignal = function(t, p){
	emi.brc(this.slt.t, t, this.signal, p);
}

BixBite.prototype.emitSignal = function(t, p){
	emi.brc(this.slt.c, t, this.signal, p);
}

/**
* COMPOUND CLASS
*/
function Compound(){ 	
	this.bhv = {};
}
Compound.extends(BixBite);

Compound.prototype.addBehaviour = function (t, behaviour, autoDispose, autoExecute){
	this.bhv[t] = new behaviour();
	this.bhv[t].compound = this;
	this.bhv[t].initialise(this.uid, this.signal, t, autoDispose, autoExecute);

	if (autoExecute) this.bhv[t].exe(this.signal);
}

Compound.prototype.removeBehaviour = function(t){
	this.bhv[t].dispose();
	this.bhv[t] = null;
	delete this.bhv[t];
}

Compound.prototype.destroy = function(){
	this.bhv = null;
	Cmp.prototype.destroy.call(this);
}

/**
* VIEW CLASS
*/
function View(){}; 
View.extends(Cmp);

View.prototype.addSlot = function(t, callback){
	emi.as(this.slt.v, this.uid, t, callback);
}
	
View.prototype.removeSlot = function(t){
	emi.rs(this.slt.v, this.uid, t);
}
	
View.prototype.sendSignal = function(t, p){
	emi.brc(this.slt.t, t, signal, p);
}

/**
* TRANSPONDER CLASS
*/
function Transponder(){}; 
Transponder.extends(Cmp);

Transponder.prototype.addSensor = function(t, callback){
	document.body.addEventListener(t, callback, false);
}
	
Transponder.prototype.removeSensor = function(t, callback){
	document.body.removeEventListener(t, callback);
}
	
Transponder.prototype.addSlot = function(t, callback){
	emi.as(this.slt.t, this.uid, t, callback, this);
}
	
Transponder.prototype.removeSlot = function(type){
	emi.rs(this.slt.t, this.uid, t);
}
	
Transponder.prototype.sendSignal = function(t, p){
	emi.brc(this.slt.c, t, this.signal, p);
}

Transponder.prototype.transmit = function(t) {
	emi.as(this.slt.t, this.uid, t, function(s){
		emi.brc(emi.slt.c, t, s);
	});
}

Transponder.prototype.responseToAll = function(t, p){
	emi.brc(this.slt.v, t, this.signal, p);
}

/**
* DATA CLASS
*/
function Data(){};
Data.extends(Cmp);

Data.prototype.sendSignal = function(t, p){
	e.brc(this.slt.c, t, this.signal, p);
}


/**
* BEHAVIOUR CLASS
*/
function Behaviour(){}

Behaviour.prototype.initialise = function(uid, signal, t, autoDispose, autoExecute){
	this.t 			= t;
	this.uid 			= uid;
		
	this.autoExecute 	= autoExecute;
	this.signal 		= signal;
	signal.autoDispose  = autoDispose;

	emi.as(emi.slt.c, uid, t, this.execute);
		
	this.init();
}

Behaviour.prototype.register = function(c){
	emi.reg(c);
}

Behaviour.prototype.unregister = function(c){
	emi.unr(c);
}

Behaviour.prototype.addResponder = function(t, callback, autoRequest){
	emi.as(this.slt.c, uid, t, callback);
	if (this.autoRequest) sendRequest(t);
}

Behaviour.prototype.removeResponder = function(t){
	emi.rs(this.slt.c, t);
}

Behaviour.prototype.sendRequest = function(t, p){
	emi.brc(this.slt.d, t, this.signal, p);
}

Behaviour.prototype.sendSignal = function(t, p){
	emi.brc(this.slt.v, t, this.signal, p);
}

Behaviour.prototype.emitSignal = function(t, p){
	emi.brc(this.slt.c, t, this.signal, p);
}

Behaviour.prototype.dispose = function(){
	emi.r(this.slt.a, this.uid, this.t);
	
	t 				= null;
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