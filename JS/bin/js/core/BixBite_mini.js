var trace=function(){console.log(Array.prototype.join.call(arguments," "))},getTimer=function(){return Date.now()||new Date},Class=function(){},p=Class.prototype;Function.prototype.extend=function(a){Class.prototype=a.prototype;this.prototype=new Class(a);this.prototype.constructor=this;return this.prototype};function Compound(){}p=Compound.prototype;p.register=function(a,b){this.e.reg(a,b)};p.unregister=function(a){this.e.unt(a)}; p.addBehaviour=function(a,b,c,j){this[a]=new b;this[a].initialise(this.e,a,c,this);j&&this[a].execute(this.s)};p.removeBehaviour=function(a){this[a].dispose();this[a]=null;delete this[a]};p.sendSignal=function(a,b){this.s.params=b;this.e.brc(this.chT,a,this.s)};p.emitSignal=function(a,b,c){this.s.params=b;!c?this.e.brc(this.chC,a,this.s,this):this.e.brcm("C",a,this.s,this)};function Data(){}p=Data.prototype;p.addSlot=function(a,b){this.e.asl(this.chD,this.uid,a,b,this)}; p.removeSlot=function(a){this.e.rsl(this.chD,this.uid,a)};p.responseTo=function(a,b,c){this.e.snd(this.chC,a,b,c?c:this)};p.responseToAll=function(a,b){this.e.brc(this.chC,a,b?b:this)};function Transponder(){}p=Transponder.prototype;p.addSlot=function(a,b){this.e.asl(this.chT,this.uid,a,b,this)};p.removeSlot=function(a){this.e.rsl(this.chT,this.uid,a)};p.sendSignal=function(a,b){this.s.params=b;this.e.brc(this.chC,a,this.s)}; p.transmit=function(a){this.e.asl(this.chT,this.uid,a,function(b){this.e.brc(this.chC,a,b)})};p.responseToAll=function(a,b){this.s.params=b;this.e.brc(this.chV,a,this.s)};p.responseTo=function(a,b,c){this.s.params=c;this.e.snd(this.chV,a,b,this.s)};p.getSlots=function(a){return this.chC[a]};p.addSensor=function(a,b){var c=this;document.body.addEventListener(a,function(){return b.apply(c,arguments)},!1)};p.removeSensor=function(a,b){document.body.removeEventListener(a,b)};function View(){}p=View.prototype; p.addSlot=function(a,b){this.e.asl(this.chV,this.uid,a,b,this)};p.removeSlot=function(a){this.rsl(this.chV,this.uid,a)};p.sendSignal=function(a,b){this.s.params=b;this.e.brc(this.chT,a,this.s)};p.emitSignal=function(a,b){this.s.params=b;this.e.brc(this.chV,a,this.s)};p.emitSignalTo=function(a,b,c){this.s.params=c;this.e.snd(this.chV,a,b,this.s)};p.getSlots=function(a){return this.chT[a]};p.registerContext=function(a,b){return this.e.bb.regCtx(this,a,b)};p.unregisterContext=function(a){this.e.bb.unrCtx(a)}; p.addContext=function(a,b){this.e.bb.addCtx(a,b)};p.onContextAdded=function(){};p.removeContext=function(a){this.e.bb.remCtx(a)};p.onContextRemoved=function(){};function Behaviour(){}p=Behaviour.prototype;p.initialise=function(a,b,c,j){this.e=a;this.uid=a.uid();this.s=this.e.add(this.uid);this.t=b;this.chC=a.chC;this.chD=a.chD;this.chT=a.chT;this.chV=a.chV;this.aDis=c;this.c=j;this.e.asl(this.chC,this.uid,b,this.execute,this);this.init()};p.register=function(a,b){this.e.reg(a,b)};p.unregister=function(a){this.e.unr(a)}; p.addResponder=function(a,b,c){this.e.asl(this.chC,this.uid,a,b,this);c&&this.sendRequest(a)};p.removeResponder=function(a){this.e.ras(this.chC,a)};p.sendRequest=function(a,b){this.s.params=b;this.e.brc(this.chD,a,this.s)};p.sendSignal=function(a,b){this.s.params=b;this.e.brc(this.chV,a,this.s)};p.sendSignalTo=function(a,b,c){this.s.params=c;this.e.snd(this.chV,a,b,this.s)};p.emitSignal=function(a,b,c){this.s.params=b;!c?this.e.brc(this.chC,a,this.s,this):this.e.brcm("C",a,this.s,this)}; p.getSlots=function(a){return this.chV[a]}; function BixBite(){function a(a){this.callerUID=a}function b(a,f){this.uid=a;this.send=f}function c(){var a,f,h=-1;this.asl=function(l,e){var c=new b(l,e);c.i=++h;a?a.n=c:f=c;a=c};this.rsl=function(b){for(var e=f,c;e.n&&e.uid!=b;)c=e,e=e.n;c&&e.n&&(c.n=e.n);e.dispose();h--;0>h&&(a=f=null)};this.brc=function(a){for(var b=f;b.n;)b.send.call(b.send._c,a),b=b.n;b.send.call(b.send._c,a)};this.gsl=function(a){for(var b=f;b.n;){if(b.uid==a)return b;b=b.n}return b.uid==a?b:null};this.ras=function(){for(var b= f,e;b.n;)e=b.n,BixBite.dispose(b),h--,b=e;BixBite.dispose(f);BixBite.dispose(a);f=a=null;h--};this.num=function(){return h+1}}function j(){var b=-1;this.chC={};this.chD={};this.chT={};this.chV={};this.add=function(b){return new a(b)};this.reg=function(b,h){if(h&&null!=this[b.uid])this[b.uid].copies++;else{var d=this.uid();this[d]=new b;this[d].uid=d;this[d].s=new a(d);this[d].e=this;this[d].chC=this.chC;this[d].chD=this.chD;this[d].chT=this.chT;this[d].chV=this.chV;this[d].init()}};this.unr=function(a){this[a]&& (0<this[a].cps?this[a].cps--:(this[a].destroy(),this[a]=null,delete this[a]))};this.asl=function(a,b,d,e,g){a[d]||(a[d]=new c);e._c=g;a[d].asl(b,e)};this.rsl=function(a,b,d){var e=a[d];e&&e.gsl(b)&&(e.rsl(b),0==e.num()&&delete a[d])};this.brcm=function(a,b,d){this.chE(a,b,d)};this.brc=function(a,b,d){a[b]&&a[b].brc(d)};this.snd=function(a,b,d,e){a[d]&&(a=a[d].gsl(b))&&a.send.call(a.send._c,e)};this.ras=function(a,b){a[b]&&(a[b].ras(),BixBite.dispose(a[b]))};this.uid=function(){return"@"+ ++b+"::"+ this.cid}}function m(b){var f=this.e=new j;f.cid=b;var c=f.chC;b=f.uid()+b;var g=new a(b);brc=function(a,b,d){f.brc(f["ch"+a],b,d)};this.register=function(a){f.reg(a,!0)};this.unregister=function(a){f.unr(a)};this.emitSignal=function(a,b){g.params=b;f.brc(c,a,g)}}var k={},g={};getContainer=function(a){return g[a]};this.spawnCore=function(a){var b=new m(a);b.e.chE=function(a,b,d){for(var c in k)c.brc(a,b,d)};b.e.bb=this;return k[a]=b};this.destroyCore=function(a){k[a]&&(this.dispose(k[a]),delete k[a])}; this.addContextRoot=function(a,b){g[a]=b};this.regCtx=function(a,b,c){g[b]&&alert("Context "+b+"is already registered");c.setAttribute("id",b);c.parentView=a;return g[b]=c};this.unrCtx=function(a){g[a]||alert("There is no such context: "+a+"registered within display list");this.remCtx(a);this.dispose(g[a]);delete g[a]};this.addCtx=function(a,b){var c=g[a];c||alert("There is no context "+a+" registered yet");g[b]||alert("Container "+b+" cannot be found");g[b].appendChild(c);c.parentView.onContextAdded()}; this.remCtx=function(a){if((a=g[a])&&a.parentNode)a.parentNode.removeChild(a),a.parentView.onContextRemoved()}}BixBite.prototype.dispose=function(a){for(var b in a)a.hasOwnProperty("destroy")&&a.destroy(),a.hasOwnProperty(b)&&delete a[b]};