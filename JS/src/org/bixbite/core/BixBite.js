/**
* BixBite v0.9.5 2.85KB gzipped (8.56KB uncompressed)
* BixBite.mini: 2.3KB gzipped (7.07KB uncompressed)
* Licensed under the Apache License, Version 2.0
* @copy (c) 2010-2013 Devu Design Ltd
* @author Daniel Wasilewski
* See LICENSE.txt
*/

//Sugar
//Why is not a Module? 
//Because BixBite framework offers modular structure by design.
var bixbite = {
    version: "0.9.5",
	trans:null,
	prefix:null
};

(function(){
	var ua = navigator.userAgent;
	if(ua.indexOf("Trident")>=0 || ua.indexOf("MSIE")>=0){bixbite.trans="msTransform";bixbite.prefix="-ms-"}
	else if(ua.indexOf("Firefox")>=0){bixbite.trans="transform";bixbite.prefix="-moz-"}
	else if(ua.indexOf("AppleWebKit")>=0){bixbite.trans="webkitTransform";bixbite.prefix="-webkit-"}
	else if(ua.indexOf("Opera")>=0){bixbite.trans="OTransform";bixbite.prefix="-o-"}
})()

//Top Level
var trace = function(){if(typeof(console) != "undefined")console.log(Array.prototype.join.call(arguments, " "))};
var getTimer = function(){return Date.now() || new Date()};
var uintToHex = function(cl){var c=cl.toString(16);return '#000000'.slice(0, -c.length) + c}
var parseVal = function(n){if(!isNaN(n)){var v=n.toString();return (v.indexOf("%")>=0)?v:n+"px"}else{return n}}

//Class inheritance model
var Class = function(s){};
var p = Class.prototype;
Function.prototype.extend=function(C){Class.prototype=C.prototype;this.prototype=new Class(C);this.prototype.constructor=this;return this.prototype};

//Enums
Event = {RESIZE:"resize", COMPLETE:"complete"}
MouseEvent = {CLICK:"click", DOUBLE_CLICK:"dblclick",MOUSE_DOWN:"mousedown",MOUSE_MOVE:"mousemove",MOUSE_OUT:"mouseout", MOUSE_OVER:"mouseover",MOUSE_UP:"mouseup"}
TouchEvent = {TAP:"click", TOUCH_START:"touchstart",TOUCH_MOVE:"touchmove",TOUCH_END:"touchend"}

/*****************************/
// BixBite framework Classes
/*****************************/
// Classes exposed for imidiate use, but not invoked.
// Compound Class
function Compound(){}
p=Compound.prototype;
p.register=function(c,sn){this.e.reg(c,sn)}
p.unregister=function(c){this.e.unr(c)}
p.addBehaviour = function(t,b,aDis,aExe){this[t]=new b();this[t].initialise(this.e,t,aDis,this);if(aExe)this[t].execute(this.s)}
p.removeBehaviour = function(t){this[t].destroy();this[t]=null;delete this[t]}
p.sendSignal=function(t,p){this.s.params=p; this.e.brc(this.chT,t,this.s)}
p.emitSignal=function(t,p,m){this.s.params=p;(!m)?this.e.brc(this.chC,t,this.s,this):this.e.brcm("C",t,this.s,this)}
p.destroy=function(){BixBite.destroy(this)}

// Data Class
function Data(){}
p=Data.prototype;
p.addSlot=function(t,cb){this.e.asl(this.chD,this.uid,t,cb,this)}
p.removeSlot=function(t){this.e.rsl(this.chD,this.uid,t)}
p.responseTo=function(uid,t,d){var vo=(d)?d:this;this.e.snd(this.chC,uid,t,vo)}
p.responseToAll=function(t,d){var vo=(d)?d:this;this.e.brc(this.chC,t,vo)}
p.destroy=function(){this.e.ras(this.chD,this.uid);BixBite.destroy(this)}
//p.destroy=function(){}

// Transponder Class
function Transponder(){}
p=Transponder.prototype;
p.addSlot=function(t,cb){this.e.asl(this.chT,this.uid,t,cb,this)}
p.removeSlot=function(t){this.e.rsl(this.chT,this.uid,t)}
p.sendSignal=function(t,p){this.s.params=p;this.e.brc(this.chC,t,this.s)}
p.transmit=function(t){this.e.asl(this.chT,this.uid,t,function(s){this.e.brc(this.chC,t,s)})}
p.responseToAll=function(t,p){this.s.params=p;this.e.brc(this.chV,t,this.s)}
p.responseTo=function(uid,t,p){this.s.params=p;this.e.snd(this.chV,uid,t,this.s)}
p.getSlots=function(t){return this.chC[t]}
p.addSensor=function(o,t,cb){var scp=this;o.body["on"+t]=function(e){e.preventDefault?e.preventDefault():e.returnValue=false;return cb.apply(scp,arguments)}}
p.removeSensor=function(o,t,cb){o.body["on"+t] = null}
p.getContext=function(id){return this.e.bb.getCtx(id)}
p.destroy=function(){this.e.ras(this.chT,this.uid);BixBite.destroy(this)}

// View Class
function View(){}
p=View.prototype;
p.addSlot=function(t,cb){this.e.asl(this.chV,this.uid,t,cb,this)}
p.removeSlot=function(t){this.rsl(this.chV,this.uid,t)}
p.sendSignal=function(t,p){this.s.params=p;this.e.brc(this.chT,t,this.s)}
p.emitSignal=function(t,p){this.s.params=p;this.e.brc(this.chV,t,this.s)}
p.emitSignalTo=function(uid,t,p){this.s.params=p;this.e.snd(this.chV,uid,t,this.s)}
p.getSlots=function(t){return this.chT[t]}
p.registerContext=function(id,ctx){return this.e.bb.regCtx(id,ctx,this)}
p.unregisterContext=function(id){this.e.bb.unrCtx(id)}
p.getContext=function(id){return this.e.bb.getCtx(id)}
p.destroy=function(){this.e.ras(this.chV,this.uid);BixBite.destroy(this)}

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
p.destroy=function(){this.e.ras(this.chC,this.uid)}

//Context Class
function Context(p){
	this.parent=p;
	this.body=document.createElement('div');
	this.gl=gl=new Graphics(this.body);
}
p = Context.prototype;
p.init = function(){};
p.addChild = function(c){this.body.appendChild(c.body);return c}
p.removeChild = function(c){this.body.removeChild(c.body);return c}
p.setID = function(id){this.body.id = id}
p.destroy = function(){};
	
//BixBite with all internal classes
function BixBite(dsp){
	this.root = dsp;
	//Signal Class
	function Signal(uid){this.callerUID=uid}
	//Slot Class
	function Slot(uid,cb){this.uid=uid;this.send=cb}
	//Slots Class
	function Slots(){
		var h,t;var i= -1;
		this.asl=function(uid,cb){var cs=new Slot(uid,cb);cs.i= ++i;(h)?h.n=cs:t=cs;h=cs}
		this.rsl=function(uid){var w=t,p;while(w.n && w.uid!=uid){p=w;w=w.n}if(p && w.n)p.n=w.n;p=null;w.destroy();w=null;i--;if(i<0)h=t=null}
		this.brc=function(s){var w=t;while(w.n){w.send.call(w.send._c,s);w=w.n}w.send.call(w.send._c,s)}
		this.gsl=function(uid){var w=t;while(w.n){if(w.uid==uid)return w;w=w.n}return(w.uid==uid)?w:null}
		this.ras=function(){var w=t,n;while(w.n){n = w.n;BixBite.destroy(w);i--;w=n}BixBite.destroy(t);BixBite.destroy(h);t=h=null;i--}
		this.num=function(){return i+1}
	}
	//Emitter Class
	function Emi(){
		var uid=-1;
		this.chC={};this.chD={};this.chT={};this.chV={};
		this.add=function(uid){return new Signal(uid)}
		this.reg=function(c,sn){
			if(sn==true && this[c.uid] != null){
				this[c.uid].copies++;
				return
			}
			var uid=this.uid();
			this[uid]=new c();
			this[uid].uid=uid;
			this[uid].s=new Signal(uid);
			this[uid].e=this;
			this[uid].chC=this.chC;
			this[uid].chD=this.chD;
			this[uid].chT=this.chT;
			this[uid].chV=this.chV;
			this[uid].init()
		}
		this.unr=function(c){
			if(!this[c]) return;
			if(this[c].cps > 0){
				this[c].cps--;return
			}
			this[c].destroy();
			this[c]=null;delete this[c]
		}
		this.asl=function(ch,uid,t,cb,c){if (!ch[t]) ch[t]=new Slots();cb._c=c;ch[t].asl(uid,cb)}
		this.rsl=function(ch,uid,t){var sl=ch[t];if (!sl || !sl.gsl(uid))return;sl.rsl(uid);if(sl.num()==0)delete ch[t]}
		this.brcm=function(cid,t,s){this.chE(cid,t,s)}
		this.brc=function(ch,t,s){if(!ch[t])return;ch[t].brc(s)}
		this.snd=function(ch,uid,t,s){if(!ch[t])return;var sl=ch[t].gsl(uid);if(sl)sl.send.call(sl.send._c,s)}
		this.ras=function(ch,t){if(!ch[t])return;ch[t].ras();BixBite.destroy(ch[t])}
		this.uid=function(){return "@"+(++uid)+"::"+(this.cid)}
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
	var cores={};
	var list={};
	//methods
	this.spawnCore=function(id){var c=new Core(id);c.e.chE=function(cid,t,s){for (var c in cores)c.brc(cid,t,s)};c.e.bb=this;return cores[id]=c}
	this.destroyCore=function(id){if(cores[id]){this.destroy(cores[id]);delete cores[id]}}
	this.getCtx=function(id){return list[id]}
	this.addContext=function(id,ctx){this.root.addChild(this.regCtx(id,ctx,null));}
	this.regCtx=function(id,ctx,v){if(list[id])alert("Context id:'" + id + "' is already registered.");list[id]=ctx;ctx.view=v;ctx.init();ctx.setID(id);return ctx}
	this.unrCtx=function(id){if (!list[id]) alert("Context id:'" + id + "' doesn't exist.");var ctx = list[id];if (ctx && ctx.parentNode){ctx.parentNode.removeChild(ctx);ctx.view = null;ctx.destroy()}delete list[id]}
	//TODO cross core comminucation
}

BixBite.prototype.destroy = function(R){if(R.hasOwnProperty("destroy")){R.destroy()}for(var p in R){if(R.hasOwnProperty(p)){delete R[p]}}R=null}
