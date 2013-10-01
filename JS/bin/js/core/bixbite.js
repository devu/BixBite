// ==ClosureCompiler==
// @output_file_name default.js
// @compilation_level SIMPLE_OPTIMIZATIONS
// ==/ClosureCompiler==

/**
 * BixBite v0.9.4
 */
 
/**
Licensed under the Apache License, Version 2.0
@copy (c) 2010-2013 See LICENSE.txt
*/

//Sugar
//Browser detection
var bixbite = {
    version: "0.9.3",
	prefix:""
};

var uAgent = navigator.userAgent;

if(uAgent.indexOf("Trident")>=0){
	bixbite.prefix = "-ms-";
} else if (uAgent.indexOf("MSIE")>=0){
	bixbite.prefix = "-ms-";
} else if(uAgent.indexOf("Firefox")>=0){
	bixbite.prefix = "-moz-";
} else if(uAgent.indexOf("AppleWebKit")>=0){
	bixbite.prefix = "-webkit-";
} else if(uAgent.indexOf("Opera")>=0){
	bixbite.prefix = "-o-"
}

//toplevel
var trace = function(){if(typeof(console) != "undefined")console.log(Array.prototype.join.call(arguments, " "))};
var getTimer = function(){return Date.now() || new Date()};
var uintToHex = function(cl){var c=cl.toString(16);return '#000000'.slice(0, -c.length) + c}
var parseVal = function(n){if(!isNaN(n)){var v=n.toString();return (v.indexOf("%")>=0)?v:n+"px"}else{return n}}

var Class = function(s){};
var p = Class.prototype;

Function.prototype.extend = function(C){
	Class.prototype = C.prototype;
	this.prototype = new Class(C);
	this.prototype.constructor = this;
	return this.prototype
};

//CSS

var styleList = document.styleSheets;
//if(styleList.length==0){
	var s = document.createElement('style');
	s.type='text/css';
	document.getElementsByTagName('head')[0].appendChild(s);
//}

var addStyleRule = function(s,st){
	styleList[0].insertRule(s+"{"+st+"}",0)
}

//default rule set
addStyleRule("html, body", "height:100%; overflow:hidden;");
addStyleRule("body", "margin:0;");
addStyleRule("div", "display:block; position:absolute;");
addStyleRule(".stage", "display:block; position:absolute; background:#ffffff; "+bixbite.prefix+"transform:translateZ(0);");
addStyleRule(".shape", "display:block; position:absolute;");
addStyleRule(".sprite", "display:block; position:absolute;");
addStyleRule(".textfield", "display:block; position:absolute; overflow:hidden; white-space:nowrap; border-color:#000000; padding:1px; text-overflow:clip");
addStyleRule(".gfx", "display:block; position:absolute;");
addStyleRule(".bitmapdata", "display:block; position:relative;");
addStyleRule(".bitmap", "display:block; position:absolute; overflow:hidden;");

//Statics
MouseEvent = {CLICK:"click", DOUBLE_CLICK:"dblclick",MOUSE_DOWN:"mousedown",MOUSE_MOVE:"mousemove",MOUSE_OUT:"mouseout", MOUSE_OVER:"mouseover",MOUSE_UP:"mouseup"}
TouchEvent = {TAP:"click", TOUCH_START:"touchstart",TOUCH_MOVE:"touchmove",TOUCH_END:"touchend"}

/*****************************/
// Virtual Display List
/*****************************/

//Graphics API
function Graphics(dsp){this.dsp = dsp;this.ctx = dsp.ctx;}
p = Graphics.prototype;
p.beginFill = function(c, a){this.c=uintToHex(c);this.a=a;}
p.setStyle = function(n){addStyleRule("."+n, this.gfx.style.cssText)}
p.applyStyle = function(n){var gfx=document.createElement("div");gfx.className=n;this.ctx.appendChild(gfx)}
p.clear = function(){while(this.ctx.firstChild)this.ctx.removeChild(this.ctx.firstChild)}
p.drawRect = function(x,y,w,h){
  var gfx=(this.gfx=document.createElement("div")).style;
  gfx.backgroundColor=this.c;
  gfx.opacity=(this.a)?this.a:1;
  gfx.left=parseVal(x);
  gfx.top=parseVal(y);
  gfx.width=parseVal(w);
  gfx.height=parseVal(h);
  this.ctx.appendChild(this.gfx);
  this.dsp.update(w,h)
}
p.drawCircle = function(x,y,r){var gfx=(this.gfx=document.createElement("div")).style;gfx.backgroundColor=this.c;gfx.opacity=(this.a)?this.a:1;gfx.left=parseVal(x-r);gfx.top=parseVal(y-r);gfx.width=parseVal(r*2);gfx.height=parseVal(r*2);gfx.borderRadius=parseVal(r);this.ctx.appendChild(this.gfx)}

//Event Dispatcher Class
function EventDispatcher(){}
p = EventDispatcher.prototype;

//Display Object Class
function DisplayObject(){
  this._r=0;
  this._sx=1;
  this._sy=1;
  this._x=0;
  this._y=0
}
p = DisplayObject.extend(EventDispatcher);

p._w = 0;
p._h = 0;

p.update = function(w,h){
  if(this._w<w) this._w = w;
  if(this._h<h) this._h = h
}

p.setCtx = function(ctx,n){
  this.ctx=document.createElement(ctx);
  this.ctx.className=n;
  this.style=this.ctx.style;
  EventDispatcher.call(this)
}

p.transform = function(){
  if(this.stage) this.style.setProperty(prefix+"transform","rotate("+this._r+"deg) scale("+this._sx+", "+this._sy+")")
}

Object.defineProperty(p,"name",{get:function(){return this.ctx.getAttribute("id")},set:function(v){this.ctx.setAttribute("id",v);}});
Object.defineProperty(p,"x",{
  get:function(){return this._x;},
  set:function(v){
    this._x=v;
    this.style.left = v+"px"
  }
});
Object.defineProperty(p,"y",{
  get:function(){return this._y;},
  set:function(v){
    this._y=v;
    this.style.top = v+"px"
  }
});
Object.defineProperty(p,"width",{
  get:function(){return this._sx*this._w;},
  set:function(v){
    this._sx = v/this._w;
    this.transform()
  }
});
Object.defineProperty(p,"height",{
  get:function(){return this._sy*this._h;},
  set:function(v){
    this._sy = v/this._h;
    this.transform()
  }
});
Object.defineProperty(p,"rotation",{
	get: function () {return this._r;},
	set:function(v){
	   this._r=v;this.transform()
	}
});
Object.defineProperty(p,"scaleX",{get: function () {return this._sx;},set:function(v){this._sx*=v;this.transform();}});
Object.defineProperty(p,"scaleY",{get: function () {return this._sy;},set:function(v){this._sy*=v;this.transform();}});
Object.defineProperty(p,"visible",{get:function () {return this._visible;},set:function(v){this._visible=v;if(!this.parent)return;if(!v){this.parent.removeChild(this);}else{this.parent.addChild(this);this.parent=null}}});
p.visible = true;

//Interactive Object Class
function InteractiveObject(){
	this.mouseChildren=true;
	DisplayObject.call(this)
}
p = InteractiveObject.extend(DisplayObject);
p.addEventListener = function(t,cb){var scp=this;this.ctx.addEventListener(t,function(){return cb.apply(scp,arguments)},false)}
p.removeEventListener = function(t){this.ctx.removeEventListener(t,cb)}
Object.defineProperty(p,"mouseChildren",{get:function(){return this._mchildren},set:function(v){this._mchildren=v}});

//DisplayObjectContainer Class
function DisplayObjectContainer(){
	this.children=[];
	InteractiveObject.call(this)
}
p = DisplayObjectContainer.extend(InteractiveObject);
p.addChildAt = function(child,index){
  child.parent=this;
 // child.stage = stage;
  child.transform();
  this.children.splice(index,0,child);
  if(child._visible){
    this.ctx.appendChild(child.ctx)
  }
}
p.addChild = function(child){return this.addChildAt(child, this.children.length);}
p.removeChildAt = function(index){
  if(index >= this.children.length) return;
  var child=this.children[index];
  this.children.splice(index,1);
  child.parent=null;
  child.stage = null;
  if(child._visible){
    this.ctx.removeChild(child.ctx)
  }
}
p.removeChild = function(child){removeChildAt(this.children.indexOf(child))}
p.getChildAt = function (index) {return this.children[index];}
p.getChildIndex = function(child){return children.indexOf(child)}
p.removeAllChildren = function (){while (this.children.length > 0) this.removeChildAt(0)}
p.getObjectsUnderPoint = function(point){var objects=[];for(var i in this.children){var o = this.children[i];objects.push(o);}return objects}

//Shape Class
function Shape(){
	DisplayObject.call(this);
	this.setCtx("div","shape");
	this.graphics.ctx=this.ctx
}
p = Shape.extend(DisplayObject);
p.graphics = new Graphics(p);

//BitmapData Class
function BitmapData(url,w,h){
  this.ctx=document.createElement("div");
  this.ctx.className="bitmapData";
  this.url="url("+url+")";
  this.width=w;this.height=h
}
p = BitmapData.prototype;
Object.defineProperty(p,"url",{get:function(){return this._url;},set:function(v){this._url=v;this.ctx.style.backgroundImage=v;}});
Object.defineProperty(p,"width",{get:function(){return this._w;},set:function(v){this._w=v;this.ctx.style.width=parseVal(v)}});
Object.defineProperty(p,"height",{get:function(){return this._h;},set:function(v){this._h=v;this.ctx.style.height=parseVal(v)}});

//Bitmap Class
function Bitmap(bd){
	DisplayObject.call(this);
	this.setCtx("div","bitmap");
	this.bitmapData=bd
}
p = Bitmap.extend(DisplayObject);
Object.defineProperty(p,"bitmapData",{get:function(){return this._bmpData;},set:function(v){this._bmpData=v;this.ctx.appendChild(v.ctx);}});

//Sprite Class
function Sprite(){
	DisplayObjectContainer.call(this);
	this.setCtx("div","sprite");
	this.graphics.ctx = this.ctx
}
p = Sprite.extend(DisplayObjectContainer);
p.graphics = new Graphics(p);

//TextField Class
function TextField(){InteractiveObject.call(this);this.setCtx("div","textfield");this._border=false;this._brColor=0xFFFFF;this._bg=false;this._bgColor=0x00000;this._multiline=false;}
p = TextField.extend(InteractiveObject);
Object.defineProperty(p,"text",{get:function(){return this.ctx.innerHTML;},set:function(v){this.ctx.innerHTML=v.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');}});
Object.defineProperty(p,"htmlText",{get:function(){return this.ctx.innerHTML;},set:function(v){this.ctx.innerHTML=v;}});
Object.defineProperty(p,"textColor",{get:function(){return this.style.color},set:function(v){this.style.color=uintToHex(v)}});
Object.defineProperty(p,"defaultTextFormat",{get:function () {return this._format;},set:function (v) {this.ctx.innerHTML = ""}});
Object.defineProperty(p,"border",{get:function(){return this._border},set:function(v){this._border=v;this.style.border=(v)?"1px solid":null;}});
Object.defineProperty(p,"borderColor",{get:function(){return this._brColor},set:function(v){this._brColor=v;this.style.borderColor=uintToHex(v);}});
Object.defineProperty(p,"background",{get: function () {return this._bg},set:function(v){this._bg=v;if(v){this.style.background=uintToHex(this.backgroundColor);}else{this.style.background=null;}}});
Object.defineProperty(p,"backgroundColor",{get:function(){return this._bgColor},set:function(v){this._bgColor=v;if(this._bg)this.style.background=uintToHex(v);}});
Object.defineProperty(p,"width",{get:function(){return this._w;},set:function(v){this._w=v; this.style.width=parseVal(v);}});
Object.defineProperty(p,"height",{get:function(){return this._h;},set:function(v){this._h=v; this.style.height=parseVal(v);}});
Object.defineProperty(p,"multiline",{get:function(){return this._multiline},set:function(v){this._multiline=v; this.style.whiteSpace=(v)?"pre":"nowrap";}});
Object.defineProperty(p,"wordWrap",{get:function(){return this._wwrap},set:function(v){this._wwrap=v; this.style.whiteSpace=(this._multiline)?"normal":this._multiline;}});

//Stage Class
function Stage(id){
	//this.stage = this;
	DisplayObjectContainer.call(this);
	this.setCtx("div","stage");
	document.body.appendChild(this.ctx)
}
p = Stage.extend(DisplayObjectContainer);
p.setMeta = function(w,h,c,a,s){
	this.style.backgroundColor=uintToHex(c);
	this.style.width=parseVal(w);
	this.style.height=parseVal(h)
}

/*****************************/
// BixBite framework Classes
/*****************************/

//Compound Class
function Compound(){}
p=Compound.prototype;
p.register=function(c,sn){
	this.e.reg(c,sn)
}
p.unregister=function(c){
	this.e.unt(c)
}
p.addBehaviour = function(t,b,aDis,aExe){
	this[t]=new b();
	this[t].initialise(this.e,t,aDis,this);
	if(aExe)this[t].execute(this.s)
}
p.removeBehaviour = function(t){
	this[t].dispose();
	this[t]=null;
	delete this[t]
}
p.sendSignal=function(t,p){
	this.s.params=p; 
	this.e.brc(this.chT,t,this.s)
}
p.emitSignal=function(t,p,m){
	this.s.params=p;
	(!m)?this.e.brc(this.chC,t,this.s,this):this.e.brcm("C",t,this.s,this)
}
p.destroy=function(){
	
}

//Data Class
function Data(){}
p=Data.prototype;
p.addSlot=function(t,cb){	
	this.e.asl(this.chD,this.uid,t,cb,this)
}
p.removeSlot=function(t){
	this.e.rsl(this.chD,this.uid,t)
}
p.responseTo=function(uid,t,d){
	var vo=(d)?d:this;
	this.e.snd(this.chC,uid,t,vo)
}
p.responseToAll=function(t,d){
	var vo=(d)?d:this;
	this.e.brc(this.chC,t,vo)
}
p.destroy=function(){
	this.e.ras(this.chD, this.uid)
}

//Transponder Class
function Transponder(){}
p=Transponder.prototype;
p.addSlot=function(t,cb){
	this.e.asl(this.chT,this.uid,t,cb,this)
}
p.removeSlot=function(t){
	this.e.rsl(this.chT,this.uid,t)
}
p.sendSignal=function(t,p){
	this.s.params=p;this.e.brc(this.chC,t,this.s)
}
p.transmit=function(t){
	this.e.asl(this.chT,this.uid,t,function(s){
		this.e.brc(this.chC,t,s)
	})
}
p.responseToAll=function(t,p){
	this.s.params=p;
	this.e.brc(this.chV,t,this.s)
}
p.responseTo=function(uid,t,p){
	this.s.params=p;
	this.e.snd(this.chV,uid,t,this.s)
}
p.getSlots=function(t){
	return this.chC[t]
}
p.addSensor=function(t,cb){
	var scp=this;
	document.body["on"+t] = function(e){
		e.preventDefault ? e.preventDefault() : e.returnValue = false;
		return cb.apply(scp, arguments)
	}
}
p.removeSensor=function(t,cb){
	document.body["on"+t] = null
}
p.getContainer=function(id){
	return this.e.bb.getCtn(id)
}

//View Class
function View(){}
p=View.prototype;
p.addSlot=function(t,cb){
	this.e.asl(this.chV,this.uid,t,cb,this)
}
p.removeSlot=function(t){
	this.rsl(this.chV,this.uid,t)
}
p.sendSignal=function(t,p){
	this.s.params=p;
	this.e.brc(this.chT,t,this.s)
}
p.emitSignal=function(t,p){
	this.s.params=p;
	this.e.brc(this.chV,t,this.s)
}
p.emitSignalTo=function(uid,t,p){
	this.s.params=p;this.e.snd(this.chV,uid,t,this.s)
}
p.getSlots=function(t){
	return this.chT[t]
}
p.registerContext=function(id,ctx){
	return this.e.bb.regCtx(this,id,ctx)
}
p.unregisterContext=function(id){
	this.e.bb.unrCtx(id)
}
p.getContainer=function(id){
	return this.e.bb.getCtn(id)
}

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

function Context(){
	this._view = null;
	Sprite.call(this)
}

p = Context.extend(Sprite);
p.init = function(){};
p.dispose = function(){};

Object.defineProperty(p,"view",{
  get:function(){return this._view;},
  set:function(v){
    this._view = v
  }
});

function ContextContainer(){
	Context.call(this);
}
p = ContextContainer.extend(Context);
	
//BixBite
function BixBite(){
	//Signal Class
	function Signal(uid){
		this.callerUID=uid
	}
	//Slot Class
	function Slot(uid,cb){
		this.uid=uid;
		this.send=cb
	}
	//Slots Class
	function Slots(){
		var h,t;
		var i= -1;
		this.asl=function(uid,cb){
			var cs=new Slot(uid,cb);
			cs.i= ++i;
			(h)?h.n=cs:t=cs;
			h=cs
		}
		this.rsl=function(uid){
			var w=t;
			var p;
			while(w.n && w.uid!=uid){
				p=w;
				w=w.n
			}
			if(p && w.n)p.n=w.n;
			p=null;
			w.dispose();
			w=null;
			i--;
			if(i<0)h=t=null
		}
		this.brc=function(s){
			var w=t;
			while(w.n){
				w.send.call(w.send._c,s);
				w=w.n
			}
			w.send.call(w.send._c,s)
		}
		this.gsl=function(uid){
			var w=t;
			while(w.n){
				if(w.uid==uid)return w;
				w=w.n
			}
			return(w.uid==uid)?w:null
		}
		this.ras=function(){
			var w=t;
			var n;
			while(w.n){
				n = w.n;
				BixBite.dispose(w);
				i--;w=n
			}
			BixBite.dispose(t);
			BixBite.dispose(h);
			t=h=null;
			i--
		}
		this.num=function(){
			return i+1
		}
	}

	//Emitter Class
	function Emi(){
		var uid=-1;
		this.chC={};
		this.chD={};
		this.chT={};
		this.chV={};
		this.add=function(uid){
			return new Signal(uid)
		}
		this.reg=function(c,sn){
			if(sn && this[c.uid] != null){
				this[c.uid].copies++;
				return
			}
			var uid=this.uid();
			this[uid]=new c();this[uid].uid=uid;
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
			if(this[c].cps > 0){this[c].cps--;
			return}this[c].destroy();
			this[c]=null;
			delete this[c]
		}
		this.asl=function(ch,uid,t,cb,c){
			if (!ch[t]) ch[t]=new Slots();
			cb._c=c;
			ch[t].asl(uid,cb)
		}
		this.rsl=function(ch,uid,t){
			var sl=ch[t];
			if (!sl || !sl.gsl(uid))return;
			sl.rsl(uid);
			if(sl.num()==0)delete ch[t]
		}
		this.brcm=function(cid,t,s){
			this.chE(cid,t,s)
		}
		this.brc=function(ch,t,s){
			if(!ch[t])return;
			ch[t].brc(s)
		}
		this.snd=function(ch,uid,t,s){
			if(!ch[t])return;
			var sl=ch[t].gsl(uid);
			if(sl)sl.send.call(sl.send._c,s)
		}
		this.ras=function(ch,t){
			if(!ch[t])return;
			ch[t].ras();
			BixBite.dispose(ch[t])
		}
		this.uid=function(){
			return "@"+(++uid)+"::"+(this.cid)
		}
	}
	
	//Core Class
	function Core(id){
		var e=this.e=new Emi();
		e.cid=id;
		var chC=e.chC;
		var uid=e.uid()+id;
		var s=new Signal(uid);
		brc=function(cid,t,s){
			var c=e['ch'+cid];
			e.brc(c,t,s)
		}
		this.register=function(c){
			e.reg(c,true)
		}
		this.unregister=function(c){
			e.unr(c)
		}
		this.emitSignal=function(t,p){
			s.params=p;
			e.brc(chC,t,s)
		}
	}
	
	var cores={};
	var list={};
	var stage = new Stage();
	
	this.getCtn=function(id){
		return list[id]
	}
	
	this.addCtn=function(id, ctn){
		ctn.id = id;
		stage.addChild(ctn);
		list[id]=ctn;
		ctn.init()
	}
	
	this.spawnCore=function(id){
		var c=new Core(id);
		c.e.chE=function(cid,t,s){
			for (var c in cores)c.brc(cid,t,s)
		};
		c.e.bb=this;
		return cores[id]=c
	}
	this.destroyCore=function(id){
		if(cores[id]){
			this.dispose(cores[id]);
			delete cores[id]
		}
	}
	
	this.regCtx=function(v,id,ctx){
		if (list[id]) alert("Context " + id + "is already registered");
		
		ctx.id=id;
		ctx.view=v;
		list[id] = ctx;
		//ctx.view.onContextAdded();
		return ctx
	}
	
	this.unrCtx=function(id){
		if (!list[id]) alert("There is no such context: " + id + "registered within display list");
		
		var ctx = list[id];
		if (ctx && ctx.parentNode){
			ctx.parentNode.removeChild(ctx);
			ctn.view = null;
			ctn.dispose();
			//ctx.view.onContextRemoved();
		}
		this.dispose(list[id]);
		delete list[id]
	}
	
	/*
	//TODO
	//this.incomingSignal
	*/
	
	this.addCtn("root", new ContextContainer());
}

BixBite.prototype.dispose = function(R){
	if(R.hasOwnProperty("destroy")){R.destroy()}
	for (var p in R){
		if(R.hasOwnProperty(p)){delete R[p]}
	}
	R=null;
}