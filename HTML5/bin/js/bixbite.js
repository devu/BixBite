/**
 * ...
 * @author Daniel Wasilewski
 */

// Class Application
function Application(){
	
	console.log("Application:init");
	
	var observer = Observer.getInstance();
	
	this.addSlot = function(type, callback){
		observer.addSlot(this, type, callback);
	}
	
	this.removeSlot = function(type){
		observer.removeSlot(this, type);
	}
	
	this.sendSignal = function(type, params){
		observer.sendSignal(type, params);
	}
}

//public methods
Application.prototype.addSlot 		= function(type, callback){};
Application.prototype.removeSlot 	= function(type){};

// Class Observer
function Observer()
{
    if ( arguments.callee.instance ) return arguments.callee.instance;
    arguments.callee.instance = this;
	
	console.log("Observer:init");
	
	var slots = new Object();
	
	this.addSlot = function(caller, type, callback){
		if(!slots[type]) slots[type] = new Slot();
		slots[type].add(caller, callback);
	}
	
	this.removeSlot = function(caller, type){
		console.log("Observer:removeSlot");
	}
	
	this.sendSignal = function(type, params){
		if (slots[type]) slots[type].send(params);
	}
}


Observer.getInstance = function() {
    var observer = new Observer();
    return observer;
};

//public methods
Observer.prototype.addSlot = function(caller, type, callback){};
Observer.prototype.removeSlot = function (caller, type){};
Observer.prototype.destroySlot = function(type){};
Observer.prototype.sendSignal = function(type, params){};
Observer.prototype.sendSignalTo = function(target, type, params){};

//Class Slot
function Slot()
{
	console.log("Slot:init");
	
	var signals = new Object();
	
	this.add = function(caller, callback){
		signals.caller = callback;
	}
	
	/*
	this.remove(caller)
	{
		//signals[caller];
	}
	*/
	this.send = function(params){
		for each (var f in signals) f(params);
	}
	
	this.sendTo = function(target, params){
		if (signals.target) signals.target(params);
	}
	
}

//public methods
Slot.prototype.add = function (caller, callback){};
Slot.prototype.send = function (params){};
Slot.prototype.sendTo = function (target, params){};

// Class Actor
	
