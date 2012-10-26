/**
 * ...
 * @author Daniel Wasilewski
 */

//SUGAR
var trace = function(p){console.log(p)};
var getTimer = function(){return Date.now() || new Date()};

var Class = function(){};
var p = Class.prototype;
p.sup = function(Class, method, params){
	if(!method) Class.call(this);
	else Class.prototype[method].call(this, params);
	this.parent = Class;
}

Function.prototype.extend = function(C){
  Class.prototype = C.prototype;
  this.prototype = new Class();
  this.prototype.constructor = this;
  return this.prototype
};

//EMITER CLASS
function Emiter(){
	//private
	var uid 	= -1
	this.slt	= { c:{}, d:{}, t:{}, v:{} }
	//register component
	this.reg = function(c,m){
		if(m==undefined){if(this[c] != null){this[c].cps++;return};}

		this[c]=new c();
		this[c].slt=this.slt;
		this[c].uid=this.uid();
		this[c].s=new Signal(this[c].uid);
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
	//signal broadcast
	this.brc = function(ch,t,s,p){
		if(!ch[t]) return;
		if(p)s.params=p;
		for(var f in ch[t]){
			ch[t][f].call(ch[t][f]._c, s);
		}
	}
	//signal send
	this.snd = function(ch,uid,t,s,p){
		if(!ch[t] || !ch[t][uid]) return;
		if(p)s.params=p;
		ch[t][uid].call(ch[t][uid]._c, s);
	}
	//data broadcast
	this.rsp = function(ch, t, dat){
		if(!ch[t]) return;
		for(var f in ch[t]){
			ch[t][f].call(ch[t][f]._c, dat);
		}
	}
	//data send
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

/*

//BASE COMPONENT CLASS
function Cmp(){this.cps = 0;}
p = Cmp.prototype;
p.destroy = function(){this.s.dispose();this.uid=null;this.slt=null;this.s=null}

//CORE DOCUMENT CLASS
function BixBite(){Cmp.call(this)};
p = BixBite.extend(Cmp);
p.register = function(c,m){emi.reg(c,m)}
p.unregister = function(c){emi.unr(c)}
p.sendSignal = function(t,p){emi.brc(this.slt.t, t, this.s, p)}
p.emitSignal = function(t,p){emi.brc(this.slt.c, t, this.s, p)}

//COMPOUND CLASS
function Compound(){BixBite.call(this)};
p = Compound.extend(BixBite);
p.bhv = {};
p.addBehaviour = function (t,b,aDis,aExe){
	var bh = new b();
	this.bhv[t] = bh;
	bh.uid = emi.uid();
	bh.s = new Signal(bh.uid);
	//bh.s.aDis=aDis;
	bh.t=t;
	bh.initialise();

	if(aExe)this.emitSignal(t);
}
p.removeBehaviour = function(t){this.bhv[t].dispose();this.bhv[t]=null;delete this.bhv[t]}
p.destroy = function(){this.bhv=null;Cmp.prototype.destroy.call(this)}

//VIEW CLASS
function View(){Cmp.call(this)};
p=View.extend(Cmp);
p.addSlot = function(t,cb){emi.asl(this.slt.v,this.uid,t,cb,this)}
p.removeSlot = function(t){emi.rsl(this.slt.v,this.uid,t)}
p.sendSignal = function(t,p){emi.brc(this.slt.t,t,this.s,p)}
p.destroy = function(){Cmp.prototype.destroy.call(this)}

//TRANSPONDER CLASS
function Transponder(){Cmp.call(this)};
p=Transponder.extend(Cmp);
p.addSensor = function(t,cb){
	var scp = this;
	document.body.addEventListener(t, function(){return cb.apply(scp, arguments)}, false);
}
p.removeSensor = function(t,cb){document.body.removeEventListener(t,cb)}
p.addSlot = function(t,cb){emi.asl(this.slt.t,this.uid,t,cb,this)}
p.removeSlot = function(t){emi.rsl(this.slt.t,this.uid,t)}
p.sendSignal = function(t,p){emi.brc(this.slt.c,t,this.s,p)}
p.transmit = function(t){emi.asl(this.slt.t,this.uid,t,function(s){emi.brc(emi.slt.c,t,s)})}
p.responseToAll = function(t,p){emi.brc(this.slt.v,t,this.s,p)}

//DATA CLASS
function Data(){Cmp.call(this)};
p=Data.extend(Cmp);
p.addSlot = function(t,cb){emi.asl(this.slt.d,this.uid,t,cb,this)}
p.removeSlot = function(t){emi.rsl(this.slt.d,this.uid,t)}
p.responseTo = function(uid,t){emi.drp(this.slt.c,uid,t,this)}
p.responseToAll = function(t){emi.rsp(this.slt.c,t,this)}

//BEHAVIOUR CLASS
function Behaviour(){}
p = Behaviour.prototype;
p.initialise = function(){
	emi.asl(emi.slt.c,this.uid,this.t,this.execute,this);
	this.init();
}
/*TODO
Behaviour.prototype.exe = function(s){
	this.execute(s);
}*/
/*
p.register = function(c,m){emi.reg(c,m)}
p.unregister = function(c){emi.unr(c)}
p.addResponder = function(t,cb,aReq){emi.asl(emi.slt.c,this.uid,t,cb,this);if(aReq)this.sendRequest(t)}
p.removeResponder = function(t){emi.rsl(emi.slt.c,t)}
p.sendRequest = function(t,p){emi.brc(emi.slt.d,t,this.s,p)}
p.sendSignal = function(t,p){emi.brc(emi.slt.v,t,this.s,p)}
p.sendSignalTo = function(uid,t,p){emi.snd(emi.slt.v,uid,t,this.s,p)}
p.emitSignal = function(t,p){emi.brc(emi.slt.c,t,this.s,p)}
p.dispose = function(){emi.r(this.slt.a,this.uid,this.t);t=null;this.aDis=null;this.aExe=null;Cmp.prototype.destroy.call(this)}

//SIGNAL CLASS
function Signal(uid){this.callerUID=uid}
Signal.prototype.dispose = function(){this.callerUID=null;this.params=null}

p = null; delete p;

trace("BixBite v0.6.4 - CORE INIT TIME: "+ (getTimer()-time));
*/