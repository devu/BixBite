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

var trace = function(p){console.log(p)}

/**
* EMITER CLASS
*/
function Emiter(){
	
	//private
	var uid 	= -1
	this.slt	= { c:{}, d:{}, t:{}, v:{} }
	//register component
	this.reg = function(c,m){
		if(m==undefined){
			if(this[c] != null){
				this[c].cps++;
				return
			};
		}

		this[c]= new c();
		this[c].slt = this.slt;
		this[c].uid = this.uid();
		this[c].s = new Signal(uid);
		this[c].init();
	}
	//unregister component
	this.unr = function(c){
		if (!this[c]) return;
		if (this[c].cps > 0){
			this[c].cps--;
			return
		}
		this[c].destroy();
		this[c]=null;
		delete this[c];
	}
	//add slot
	this.asl = function (ch,uid,t,cb,c){
		if(!ch[t]) ch[t]={};
		cb._c=c;
		ch[t][uid]=cb;
	}
	//remove slot
	this.rsl = function(ch,uid,t){if(!ch[t]) return;delete ch[t][uid];}
	//broadcast
	this.brc = function(ch,t,s,p){
		if(!ch[t]) return;
		if(p)s.params=p;
		for(var f in ch[t]){
			ch[t][f].call(ch[t][f]._c, s);
		}
	}
	//response
	this.rsp = function(ch, t, dat){
		if(!ch[t] || !ch[t][uid]) return;
		for(var f in ch[t]){
			ch[t][f].call(ch[t][f]._c, dat);
		}
	}
	//data response
	this.drp = function(ch, uid, t, dat){
		if(!ch[t] || !ch[t][uid]) return;
		ch[t][uid].call(ch[t][uid]._c, dat);
	}
	//remove all slots
	this.ras = function(ch, t){if (!ch[t]) return;for (var f in ch[t]) removeSlot(ch,uid,t);delete ch[t];}
	//getters/setters
	this.uid = function(){ return "@"+ (++uid); }
}

var emi = new Emiter();

/**
* BASE COMPONENT CLASS
*/
function Cmp(){
	this.cps = 0;
}

Cmp.prototype.destroy = function(){this.s.dispose();this.uid=null;this.slt=null;this.s=null}

/**
* CORE DOCUMENT CLASS
*/
function BixBite(){};
BixBite.extends(Cmp);
BixBite.prototype.register = function(c,m){emi.reg(c,m)}
BixBite.prototype.unregister = function(c){emi.unr(c)}
BixBite.prototype.sendSignal = function(t,p){emi.brc(this.slt.t, t, this.s, p)}
BixBite.prototype.emitSignal = function(t,p){emi.brc(this.slt.c, t, this.s, p)}

/**
* COMPOUND CLASS
*/
function Compound(){this.bhv={}};
Compound.extends(BixBite);
Compound.prototype.addBehaviour = function (t,b,aDis,aExe){
	var bh = this.bhv[t] = new b();
	bh.uid = emi.uid();
	bh.s = new Signal(bh.uid);
	//bh.s.aDis=aDis;
	bh.t=t;
	bh.initialise();

	if(aExe)this.emitSignal(t);
}
Compound.prototype.removeBehaviour = function(t){this.bhv[t].dispose();this.bhv[t]=null;delete this.bhv[t]}
Compound.prototype.destroy = function(){this.bhv=null;Cmp.prototype.destroy.call(this)}

/**
* VIEW CLASS
*/
function View(){}; 
View.extends(Cmp);
View.prototype.addSlot = function(t,cb){emi.asl(this.slt.v,this.uid,t,cb,this)}
View.prototype.removeSlot = function(t){emi.rsl(this.slt.v,this.uid,t)}
View.prototype.sendSignal = function(t,p){emi.brc(this.slt.t,t,this.s,p)}
View.prototype.destroy = function(){Cmp.prototype.destroy.call(this)}

/**
* TRANSPONDER CLASS
*/
function Transponder(){};
Transponder.extends(Cmp);
Transponder.prototype.addSensor = function(t,cb){
	var scp = this;
	document.body.addEventListener(t, function(){return cb.apply(scp, arguments)}, false);
}
Transponder.prototype.removeSensor = function(t,cb){document.body.removeEventListener(t,cb)}
Transponder.prototype.addSlot = function(t,cb){emi.asl(this.slt.t,this.uid,t,cb,this)}
Transponder.prototype.removeSlot = function(t){emi.rsl(this.slt.t,this.uid,t)}
Transponder.prototype.sendSignal = function(t,p){emi.brc(this.slt.c,t,this.s,p)}
Transponder.prototype.transmit = function(t){emi.asl(this.slt.t,this.uid,t,function(s){emi.brc(emi.slt.c,t,s)})}
Transponder.prototype.responseToAll = function(t,p){emi.brc(this.slt.v,t,this.s,p)}

/**
* DATA CLASS
*/
function Data(){};
Data.extends(Cmp);
Data.prototype.addSlot = function(t,cb){emi.asl(this.slt.d,this.uid,t,cb,this)}
Data.prototype.removeSlot = function(t){emi.rsl(this.slt.d,this.uid,t)}
Data.prototype.responseTo = function(uid,t){emi.drp(this.slt.c,uid,t,this)}

/**
* BEHAVIOUR CLASS
*/
function Behaviour(){}


Behaviour.prototype.initialise = function(){
	emi.asl(emi.slt.c,this.uid,this.t,this.execute,this);
	this.init();
}
/*TODO
Behaviour.prototype.exe = function(s){
	this.execute(s);
}*/
Behaviour.prototype.register = function(c,m){emi.reg(c,m)}
Behaviour.prototype.unregister = function(c){emi.unr(c)}
Behaviour.prototype.addResponder = function(t,cb,aReq){emi.asl(emi.slt.c,this.uid,t,cb,this);if(aReq)this.sendRequest(t)}
Behaviour.prototype.removeResponder = function(t){emi.rs(emi.slt.c,t)}
Behaviour.prototype.sendRequest = function(t,p){emi.brc(emi.slt.d,t,this.s,p)}
Behaviour.prototype.sendSignal = function(t,p){emi.brc(emi.slt.v,t,this.s,p)}
Behaviour.prototype.emitSignal = function(t,p){emi.brc(emi.slt.c,t,this.s,p)}
Behaviour.prototype.dispose = function(){emi.r(this.slt.a,this.uid,this.t);t=null;this.aDis=null;this.aExe=null;Cmp.prototype.destroy.call(this)}

/**
* SIGNAL CLASS
*/
function Signal(uid){this.callerUID=uid}
Signal.prototype.dispose = function(){this.callerUID=null;this.params=null}

trace("BixBite v0.6.4 - CORE INIT TIME: "+ (new Date()-time));