/**
* BixBite v0.9.5 compatible
* Licensed under the Apache License, Version 2.0
* @copy (c) 2010-2013 Devu Design Ltd
* @author Daniel Wasilewski
* See LICENSE.txt
*/

/*************************************/
// Multipurpose Virtual Display List 
// DOM/SVG/CANVAS
/*************************************/

//CSS - dynamic way in future releases but it will not be <IE9 compatible
/*
var styleList = document.styleSheets;
var s = document.createElement('style');
s.type='text/css';
document.getElementsByTagName('head')[0].appendChild(s);
var addStyleRule = function(s,st){styleList[0].insertRule(s+"{"+st+"}",0)}

//default rule set
addStyleRule("html, body", "height:100%; overflow:hidden;");
addStyleRule("body", "margin:0;");
addStyleRule("div", "display:block; position:absolute;");
addStyleRule("svg", "left:0px; top:0px; margin:0; display:block; position:absolute; pointer-events:none;");
addStyleRule("canvas", " margin:0; display:block; position:absolute;");
addStyleRule(".flash", "margin:0; display:block; overflow:hidden;");
*/
//Graphic Library API
var GL = {
	
	DOM:'dom',
	SVG:'svg',
	CANVAS:'canvas',
	
	dom:{
		beginFill:function(ctx,c,a){
			this.gfx=document.createElement("div");
			ctx.appendChild(this.gfx);
			
			this.node=this.gfx;
			this.c = uintToHex(c);
			this.a=a;
		},
		beginBitmapFill:function(ctx,bd,m,r,s){
			this.bd=bd;
			this.m=m;
		},
		drawRect:function(ctx,x,y,w,h){
			var s=this.node.style;
			s.backgroundColor=this.c;
			s.opacity=(this.a)?this.a:1;
			s.left=parseVal(x);
			s.top=parseVal(y);
			s.width=parseVal(w);
			s.height=parseVal(h);
		},
		drawCircle:function(ctx,x,y,r){
			var s=this.node.style;
			s.backgroundColor=this.c;
			s.opacity=(this.a)?this.a:1;
			s.left=parseVal(x-r);
			s.top=parseVal(y-r);
			s.width=parseVal(r*2);
			s.height=parseVal(r*2);
			s.borderRadius=parseVal(r);
		},
		rotate:function(ctx,a){
			ctx.style[bixbite.trans] = "rotate("+a+"deg)";
		},
		move:function(ctx,x,y){
			ctx.style.left = parseVal(x);
			ctx.style.top = parseVal(y);
		}
	},
	
	svg:{
		NS:"http://www.w3.org/2000/svg",
		init:function(ctx,w,h){
			
			this.svg=document.createElementNS(this.NS,"svg");
			this.svg.setAttribute("version", "1.1");
			this.svg.setAttribute("xmlns", this.NS);
			this.svg.setAttribute("width", w+"px");
			this.svg.setAttribute("height", h+"px");
			//this.svg.setAttribute("viewBox", "0 0 0 0");
			ctx.appendChild(this.svg);
		},
		beginFill:function(ctx,c,a){
			this.c=uintToHex(c);
			this.a=a;
		},
		beginBitmapFill:function(ctx,bd,m,r,s){
			this.bd=bd;
			this.m=m;
		},
		drawRect:function(ctx,x,y,w,h){
			this.gfx=document.createElementNS(this.NS, "rect");
			
			this.gfx.setAttribute("width", w);
			this.gfx.setAttribute("height", h);
			this.gfx.setAttribute("x", x);
			this.gfx.setAttribute("y", y);
			this.svg.appendChild(this.gfx);
			
			this.gfx.setAttribute("fill",this.c);
		},
		rotate:function(ctx,a){
			ctx.style[bixbite.trans] = "rotate("+a+"deg)";
		},
		move:function(ctx,x,y){
			ctx.style.left = parseVal(x);
			ctx.style.top = parseVal(y);
		}
	},
	
	canvas:{
		init:function(ctx,w,h){
			this.gfx=document.createElement("canvas");
			this.gfx.setAttribute("width", w+"px");
			this.gfx.setAttribute("height", h+"px");
			ctx.appendChild(this.gfx);
			this.node=this.gfx;
			this.ctx=this.node.getContext("2d");
		},
		beginFill:function(ctx,c,a){
			this.c=uintToHex(c);
			this.a=a;
		},
		beginBitmapFill:function(ctx,bd,m,r,s){
			this.bd=bd;
			this.m=m;
		},
		drawRect:function(ctx,x,y,w,h){
			this.ctx.fillStyle=this.c;
			this.ctx.fillRect(x,y,w,h);
		},
		rotate:function(ctx,a){
			//
		},
		move:function(ctx,x,y){
			//
		}
	}
};

function Graphics(ctx){
	this._mode;
	this.ctx = ctx; 
	this.gl = GL.dom;
}
p = Graphics.prototype;
p.setMode=function(v,w,h){
	this._mode = v;
	if(v==GL.DOM){this.gl = GL.dom} 
	else if(v==GL.SVG){this.gl = GL.svg;this.gl.init(this.ctx,w,h)} 
	else if(v==GL.CANVAS){this.gl = GL.canvas;this.gl.init(this.ctx,w,h)}
}

p.clear = function(){this.ctx.innerHTML="";}
p.beginFill = function(c,a){this.gl.beginFill(this.ctx,c,a);}
p.beginBitmapFill = function(bd,m,r,s){this.gl.beginBitmapFill(this.ctx,bd,m,r,s);}
p.endFill = function(){}
p.drawRect = function(x,y,w,h){this.gl.drawRect(this.ctx,x,y,w,h);}
p.drawCircle = function(x,y,r){this.gl.drawCircle(this.ctx,x,y,r);}
p.rotate = function(a){this.gl.rotate(this.ctx,a);}
p.move = function(x,y){this.gl.move(this.ctx,x,y);}

function MultiDisplayList(n){this.root=n;}
p = MultiDisplayList.prototype;
p.addChild = function(c){this.root.appendChild(c.body);return c}
p.removeChild = function(c){this.root.removeChild(c.body);return c}
