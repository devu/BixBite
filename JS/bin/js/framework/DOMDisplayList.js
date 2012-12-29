//Browser detection
var uAgent = navigator.userAgent;
var prefix;
if(uAgent.indexOf("Trident")>=0){
  prefix = "-ms-";
} else if(uAgent.indexOf("Firefox")>=0){
  prefix = "-moz-";
} else if(uAgent.indexOf("AppleWebKit")>=0){
  prefix = "-webkit-";
} else if(uAgent.indexOf("Opera")>=0){
  prefix = "-o-";
} else {
  prefix ="";
}

//Helpers
var uintToHex = function(cl){var c=cl.toString(16);return '#000000'.slice(0, -c.length) + c;}
var parseVal = function(n){if(!isNaN(n)){var v=n.toString();return (v.indexOf("%")>=0)?v:n+"px";}else{return n;}}

//Statics
MouseEvent = {CLICK:"click", DOUBLE_CLICK:"dblclick",MOUSE_DOWN:"mousedown",MOUSE_MOVE:"mousemove",MOUSE_OUT:"mouseout", MOUSE_OVER:"mouseover",MOUSE_UP:"mouseup"}

//CSS
var styleList = document.styleSheets;
if(styleList.length==0){var s = document.createElement('style');s.type='text/css';document.getElementsByTagName('head')[0].appendChild(s);}
var addStyleRule = function(s,st){styleList[0].insertRule(s+"{"+st+"}",0);}

//default rule set
addStyleRule("html, body", "height:100%; overflow:hidden;");
addStyleRule("body", "margin:0;");
addStyleRule("div", "display:block; position:absolute;");
addStyleRule(".stage", "display:block; position:absolute; background:#ffffff; "+prefix+"transform:translateZ(0);");
addStyleRule(".shape", "display:block; position:absolute;");
addStyleRule(".sprite", "display:block; position:absolute;");
addStyleRule(".textfield", "display:block; position:absolute; overflow:hidden; white-space:nowrap; border-color:#000000; padding:1px; text-overflow:clip");
addStyleRule(".gfx", "display:block; position:absolute;");
addStyleRule(".bitmapdata", "display:block; position:relative;");
addStyleRule(".bitmap", "display:block; position:absolute; overflow:hidden;");

//Graphics API
function Graphics(dsp){this.dsp = dsp;this.ctx = dsp.ctx;}
p = Graphics.prototype;
p.beginFill = function(c, a){this.c=uintToHex(c);this.a=a;}
p.setStyle = function(n){addStyleRule("."+n, this.gfx.style.cssText);}
p.applyStyle = function(n){var gfx=document.createElement("div");gfx.className=n;this.ctx.appendChild(gfx);}
p.clear = function(){while(this.ctx.firstChild)this.ctx.removeChild(this.ctx.firstChild);}
p.drawRect = function(x,y,w,h){
  var gfx=(this.gfx=document.createElement("div")).style;
  gfx.backgroundColor=this.c;
  gfx.opacity=(this.a)?this.a:1;
  gfx.left=parseVal(x);
  gfx.top=parseVal(y);
  gfx.width=parseVal(w);
  gfx.height=parseVal(h);
  this.ctx.appendChild(this.gfx);
  this.dsp.update(w,h);
}
p.drawCircle = function(x,y,r){var gfx=(this.gfx=document.createElement("div")).style;gfx.backgroundColor=this.c;gfx.opacity=(this.a)?this.a:1;gfx.left=parseVal(x-r);gfx.top=parseVal(y-r);gfx.width=parseVal(r*2);gfx.height=parseVal(r*2);gfx.borderRadius=parseVal(r);this.ctx.appendChild(this.gfx);}

//*** Display List ***

//Event Dispatcher Class
function EventDispatcher(){}
p = EventDispatcher.prototype;

//Display Object Class
function DisplayObject(){
  this._r=0;
  this._sx=1;
  this._sy=1;
  this._x=0;
  this._y=0;
}
p = DisplayObject.extend(EventDispatcher);

p._w = 0;
p._h = 0;

p.update = function(w,h){
  if(this._w<w) this._w = w;
  if(this._h<h) this._h = h;
}

p.setCtx = function(ctx,n){
  this.ctx=document.createElement(ctx);
  this.ctx.className=n;
  this.style=this.ctx.style;
  EventDispatcher.call(this);
}

p.transform = function(){
  if(this.stage) this.style.setProperty(prefix+"transform","rotate("+this._r+"deg) scale("+this._sx+", "+this._sy+")");
}

Object.defineProperty(p,"name",{get:function(){return this.ctx.getAttribute("id")},set:function(v){this.ctx.setAttribute("id",v);}});
Object.defineProperty(p,"x",{
  get:function(){return this._x;},
  set:function(v){
    this._x=v;
    this.style.left = v+"px";
  }
});
Object.defineProperty(p,"y",{
  get:function(){return this._y;},
  set:function(v){
    this._y=v;
    this.style.top = v+"px";
  }
});

Object.defineProperty(p,"width",{
  get:function(){return this._sx*this._w;},
  set:function(v){
    this._sx = v/this._w;
    this.transform();
  }
});
Object.defineProperty(p,"height",{
  get:function(){return this._sy*this._h;},
  set:function(v){
    this._sy = v/this._h;
    this.transform();
  }
});
Object.defineProperty(p,"rotation",{get: function () {return this._r;},set:function(v){this._r=v;this.transform();}});
Object.defineProperty(p,"scaleX",{get: function () {return this._sx;},set:function(v){this._sx*=v;this.transform();}});
Object.defineProperty(p,"scaleY",{get: function () {return this._sy;},set:function(v){this._sy*=v;this.transform();}});
Object.defineProperty(p,"visible",{get:function () {return this._visible;},set:function(v){this._visible=v;if(!this.parent)return;if(!v){this.parent.removeChild(this);}else{this.parent.addChild(this);this.parent=null;}}});
p.visible = true;

//Interactive Object Class
function InteractiveObject(){this.mouseChildren=true;DisplayObject.call(this);}
p = InteractiveObject.extend(DisplayObject);
p.addEventListener = function(t,cb){var scp=this;this.ctx.addEventListener(t,function(){return cb.apply(scp,arguments)},false);}
p.removeEventListener = function(t){this.ctx.removeEventListener(t,cb);}
Object.defineProperty(p,"mouseChildren",{get:function(){return this._mchildren;},set:function(v){this._mchildren=v;}});

//DisplayObjectContainer Class
function DisplayObjectContainer(){this.children=[];InteractiveObject.call(this);}
p = DisplayObjectContainer.extend(InteractiveObject);
p.addChildAt = function(child,index){
  child.parent=this;
  child.stage = stage;
  child.transform();
  this.children.splice(index,0,child);
  if(child._visible){
    this.ctx.appendChild(child.ctx);
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
    this.ctx.removeChild(child.ctx);
  }
}
p.removeChild = function(child){removeChildAt(this.children.indexOf(child));}
p.getChildAt = function (index) {return this.children[index];}
p.getChildIndex = function(child){return children.indexOf(child);}
p.removeAllChildren = function (){while (this.children.length > 0) this.removeChildAt(0);}
p.getObjectsUnderPoint = function(point){var objects=[];for(var i in this.children){var o = this.children[i];objects.push(o);}return objects;}

//Shape Class
function Shape(){DisplayObject.call(this);this.setCtx("div","shape");this.graphics.ctx=this.ctx;}
p = Shape.extend(DisplayObject);
p.graphics = new Graphics(p);

//BitmapData Class
function BitmapData(url,w,h){
  this.ctx=document.createElement("div");
  this.ctx.className="bitmapData";
  this.url="url("+url+")";
  this.width=w;this.height=h;
}
p = BitmapData.prototype;
Object.defineProperty(p,"url",{get:function(){return this._url;},set:function(v){this._url=v;trace(this.ctx);this.ctx.style.backgroundImage=v;}});
Object.defineProperty(p,"width",{get:function(){return this._w;},set:function(v){this._w=v;this.ctx.style.width=parseVal(v)}});
Object.defineProperty(p,"height",{get:function(){return this._h;},set:function(v){this._h=v;this.ctx.style.height=parseVal(v)}});

//Bitmap Class
function Bitmap(bd){DisplayObject.call(this);this.setCtx("div","bitmap");this.bitmapData=bd;}
p = Bitmap.extend(DisplayObject);
Object.defineProperty(p,"bitmapData",{get:function(){return this._bmpData;},set:function(v){this._bmpData=v;this.ctx.appendChild(v.ctx);}});

//Sprite Class
function Sprite(){DisplayObjectContainer.call(this);this.setCtx("div","sprite");this.graphics.ctx = this.ctx;}
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
function Stage(id){DisplayObjectContainer.call(this);this.setCtx("div","stage");document.body.appendChild(this.ctx);}
p = Stage.extend(DisplayObjectContainer);
p.setMeta = function(w,h,c,a,s){this.style.backgroundColor=uintToHex(c);this.style.width=parseVal(w);this.style.height=parseVal(h);}

p=null; delete p;
