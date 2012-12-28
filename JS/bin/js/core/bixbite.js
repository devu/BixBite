/**
 * BixBite v0.9.2
 * Structure mostly implemented except 3 key points:
 * -Deconstruction
 * -Context abstraction layer
 * -Multi core communication
 */
 
/**
The MIT License

@copy (c) 2012 Devu Design Limited, Daniel Wasilewski

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

//Sugar
var trace = function(){console.log(Array.prototype.join.call(arguments, " "))};
var getTimer = function(){return Date.now() || new Date()};

var Class = function(s){};
var p = Class.prototype;

Function.prototype.extend = function(C){
	Class.prototype = C.prototype;
	this.prototype = new Class(C);
	this.prototype.constructor = this;
	return this.prototype
};

//Compound Class
function Compound(){}
p=Compound.prototype;
p.register=function(c,sn){this.e.reg(c,sn)}
p.unregister=function(c){this.e.unt(c);}
p.addBehaviour = function (t,b,aDis,aExe){this[t]=new b();this[t].initialise(this.e,t,aDis,this);if(aExe)this[t].execute(this.s)}
p.removeBehaviour = function(t){this[t].dispose();this[t]=null;delete this[t]}
p.sendSignal=function(t,p){this.s.params=p; this.e.brc(this.chT,t,this.s)}
p.emitSignal=function(t,p,m){this.s.params=p;(!m)? this.e.brc(this.chC,t,this.s,this):this.e.brcm("C",t,this.s,this)}

//Data Class
function Data(){}
p=Data.prototype;
p.addSlot=function(t,cb){this.e.asl(this.chD,this.uid,t,cb,this)}
p.removeSlot=function(t){this.e.rsl(this.chD,this.uid,t)}
p.responseTo=function(uid,t,d){var vo=(d)?d:this;this.e.snd(this.chC,uid,t,vo)}
p.responseToAll=function(t,d){var vo=(d)?d:this;this.e.brc(this.chC,t,vo)}

//Transponder Class
function Transponder(){}
p=Transponder.prototype;
p.addSlot=function(t,cb){this.e.asl(this.chT,this.uid,t,cb,this)}
p.removeSlot=function(t){this.e.rsl(this.chT,this.uid,t)}
p.sendSignal=function(t,p){this.s.params=p;this.e.brc(this.chC,t,this.s)}
p.transmit=function(t){this.e.asl(this.chT,this.uid,t,function(s){this.e.brc(this.chC,t,s)})}
p.responseToAll=function(t,p){this.s.params=p;this.e.brc(this.chV,t,this.s)}
p.responseTo=function (uid,t,p){this.s.params=p;this.e.snd(this.chV,uid,t,this.s)}
p.getSlots=function(t){return this.chC[t]}
p.addSensor=function(t,cb){var scp=this;document.body.addEventListener(t, function(){return cb.apply(scp, arguments)},false)}
p.removeSensor=function(t,cb){document.body.removeEventListener(t,cb)}
//TODO
//p.getContextArray 
//p.getContextById

//View Class
function View(){}
p=View.prototype;
p.addSlot=function(t,cb){this.e.asl(this.chV,this.uid,t,cb,this)}
p.removeSlot=function(t){this.rsl(this.chV,this.uid,t)}
p.sendSignal=function(t,p){this.s.params=p;this.e.brc(this.chT,t,this.s)}
p.emitSignal=function(t,p){this.s.params=p;this.e.brc(this.chV,t,this.s)}
p.emitSignalTo=function(uid,t,p){this.s.params=p;this.e.snd(this.chV,uid,t,this.s)}
p.getSlots=function(t){return this.chT[t]}
//TODO
//p.registerContext(id:String, context:Class)
//p.unregisterContext(id:String)
//p.addContext(contextId:String, containerId:String)
//p.removeContext(contextId:String)

//Behaviour Class
function Behaviour(){}
p=Behaviour.prototype;
p.initialise = function(e,t,aDis,c){this.e=e;this.uid=e.uid();this.s=this.e.add(this.uid);this.t=t;this.chC=e.chC;this.chD=e.chD;this.chT=e.chT;this.chV=e.chV;this.aDis=aDis;this.c=c;this.e.asl(this.chC,this.uid,t,this.execute,this);this.init()}
p.register=function(c,sn){this.e.reg(c,sn)}
p.unregister=function(c){this.e.unr(c)}
p.addResponder=function(t,cb,aReq){this.e.asl(this.chC,this.uid,t,cb,this);if(aReq)this.sendRequest(t)}
p.removeResponder=function(t){this.e.ras(this.chC,t)}
p.sendRequest=function(t,p){this.s.params=p;this.e.brc(this.chD,t,this.s)}
p.sendSignal=function(t,p){this.s.params=p;this.e.brc(this.chV,t,this.s)}
p.sendSignalTo=function(uid,t,p){this.s.params=p;this.e.snd(this.chV,uid,t,this.s)}
p.emitSignal=function(t,p,m){this.s.params=p;(!m)? this.e.brc(this.chC,t,this.s,this):this.e.brcm("C",t,this.s,this)}
p.getSlots=function(t){return this.chV[t]}
//TODO
//autoDispose
	
//BixBite
function BixBite(){

	//Signal Class
	function Signal(uid){this.callerUID=uid;}

	//Slot Class
	function Slot(uid,cb){this.uid=uid;this.send=cb}

	//Slots Class
	function Slots(type){
		var type=type;
		var h,t;
		var i= -1;
		this.asl=function(uid,cb){var cs=new Slot(uid,cb);cs.i= ++i;(h)?h.n=cs:t=cs;h=cs}
		this.rsl=function(uid){var w=t;var p;while(w.n && w.uid!=uid){p=w;w=w.n;}if(p && w.n)p.n=w.n;p=null;w.dispose();w=null;i--;if(i<0)h=t=null}
		this.brc=function(s){var w=t;while(w.n){w.send.call(w.send._c,s);w=w.n;}w.send.call(w.send._c,s)}
		this.gsl=function(uid){var w=t;while(w.n){if(w.uid==uid)return w;w=w.n;}return(w.uid==uid)?w:null}
		this.ras=function(){var w=t;var n;while(w.n){n = w.n;dispose(w);i--;w=n;}dispose(t);dispose(h);t=h=null;i--}
		this.num=function(){return i+1;}
	}

	//Emitter Class
	function Emi(){
		var uid=-1;
		this.chC={};this.chD={};this.chT={};this.chV={};
		this.add=function(uid){return new Signal(uid)}
		this.reg=function(c,sn){if(sn && this[c.uid] != null){this[c.uid].copies++;return}var uid=this.uid();this[uid]=new c();this[uid].uid=uid;this[uid].s=new Signal(uid);this[uid].e=this;this[uid].chC=this.chC;this[uid].chD=this.chD;this[uid].chT=this.chT;this[uid].chV=this.chV;this[uid].init()}
		this.unr=function(c){if(!this[c]) return;if(this[c].cps > 0){this[c].cps--;return}this[c].destroy();this[c]=null;delete this[c]}
		this.asl=function(ch,uid,t,cb,c){if (!ch[t]) ch[t]=new Slots(t);cb._c=c;ch[t].asl(uid,cb)}
		this.rsl=function(ch,uid,t){var sl=ch[t];if (!sl || !sl.gsl(uid))return;sl.rsl(uid);if(sl.num()==0)delete ch[t]}
		this.brcm=function(cid,t,s){this.chE(cid,t,s)}
		this.brc=function(ch,t,s){if(!ch[t])return;ch[t].brc(s)}
		this.snd=function(ch,uid,t,s){if(!ch[t])return;var sl=ch[t].gsl(uid);if(sl)sl.send.call(sl.send._c,s)}
		this.uid=function(){return "@"+(++uid)+"::"+(this.cid)}
		this.ras=function(ch,t){if(!ch[t])return ch[t].ras();dispose(ch[t])}
	}
	
	//Core Class
	function Core(id){
		var e=this.e=new Emi();
		e.cid=id;
		var chC=e.chC;
		var uid=e.uid()+id;
		var s=new Signal(uid);
		brc=function(cid,t,s){var c=e['ch'+cid];e.brc(c,t,s)}
		this.register=function(c){e.reg(c,true)}
		this.unregister=function(c){e.unr(c)}
		this.emitSignal=function(t,p){s.params=p;e.brc(chC,t,s)}
	}
	
	var cores={};list={};
	getContainer=function(id){return list[id]}
	this.spawnCore=function(id){
		var c=new Core(id);
		c.e.chE=function(cid,t,s){for (var c in cores)c.brc(cid,t,s)};
		c.e.bb=this;
		return cores[id]=c
	}
	this.destroyCore=function(id){if(cores[id]){this.dispose(cores[id]);delete cores[id]}}
	this.addContextRoot=function(id, root){list[id]=root}
	//TODO
	//this.incomingSignal
	//registerCtx
	//unregisterCtx
	//addCtx
	//removeCtx
};

BixBite.prototype.dispose = function(R){
	for (var p in R){
		if(R.hasOwnProperty("destroy")){R.destroy();}
		if(R.hasOwnProperty(p)){R[p]=null;delete R[p];}
	}
	R=null;delete R;
}
	